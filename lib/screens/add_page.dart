import 'package:flutter/material.dart';
import 'package:loto_app/services/todo_service.dart';
import 'package:loto_app/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  final String userToken;
  const AddTodoPage({Key? key, required this.userToken, this.todo})
      : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      final priority = todo['priority'];
      titleController.text = title;
      descriptionController.text = description;
      priorityController.text = priority.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Todo" : "Add Todo")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          TextField(
            controller: priorityController,
            decoration: const InputDecoration(hintText: 'Priority'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                isEdit ? updateData() : submitData();
              },
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(isEdit ? "Update" : 'Submit')))
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call update widget');
      return;
    }
    final id = todo['id'].toString();

    // Get the data from form
    final response = await TodoService.updateTodo(id, body, widget.userToken);

    if (response) {
      showDialogMassage(context, message: 'Success');
    } else {
      showDialogMassage(context, message: 'Something went wrong');
    }
  }

  Future<void> submitData() async {
    //Get the data from form
    final response = await TodoService.addTodo(body, widget.userToken);
    if (response) {
      showDialogMassage(context, message: 'Success');
    } else {
      showDialogMassage(context, message: 'Something went wrong');
    }
  }

  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    final priority = priorityController.text;
    return {
      "title": title,
      "description": description,
      "priority": priority,
      "complete": false
    };
  }
}
