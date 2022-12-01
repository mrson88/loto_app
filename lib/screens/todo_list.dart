import 'package:flutter/material.dart';
import 'package:loto_app/screens/add_page.dart';
import 'package:loto_app/services/todo_service.dart';
import 'package:loto_app/utils/snackbar_helper.dart';
import 'package:loto_app/widget/todo_card.dart';

class TodoListPage extends StatefulWidget {
  final String userToken;
  const TodoListPage({Key? key, required this.userToken}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      fetchTodo();
    } catch (e) {
      // print(e.toString());
    } finally {
      fetchTodo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No todo items',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['id'].toString();
                  return TodoCard(
                      index: index,
                      item: item,
                      userToken: widget.userToken,
                      navigateEdit: navigateToEditPage,
                      deleteById: deletebyID);
                }),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToAddPage();
          },
          label: const Text('Add Todo')),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
        builder: (context) => AddTodoPage(
              userToken: widget.userToken,
            ));
    await Navigator.push(context, route);

    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
        builder: (context) => AddTodoPage(
              userToken: widget.userToken,
              todo: item,
            ));
    await Navigator.push(context, route);
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    final userToken = widget.userToken;
    final response = await TodoService.fetchTodos(userToken);

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showDialogMassage(context, message: 'Something went Wrong');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deletebyID(String id) async {
    final userToken = widget.userToken;
    final isSuccess = await TodoService.deleteByID(id, userToken);
    if (isSuccess) {
      setState(() {
        fetchTodo();
      });
      showDialogMassage(context, message: 'Success');
    } else {
      showDialogMassage(context, message: 'Delete Fail');
    }
  }
}
