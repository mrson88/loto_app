import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final String userToken;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  const TodoCard(
      {Key? key,
      required this.index,
      required this.item,
      required this.userToken,
      required this.navigateEdit,
      required this.deleteById})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = item['id'].toString();
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              navigateEdit(item);
              //edit
            } else if (value == 'delete') {
              //delete
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              )
            ];
          },
        ),
      ),
    );
  }
}
