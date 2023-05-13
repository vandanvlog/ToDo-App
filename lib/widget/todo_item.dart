import 'package:flutter/material.dart';
import 'package:listview_one/constants/color.dart';
import 'package:listview_one/delete.dart';
import 'package:listview_one/model/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onDeleteItem,
      required this.onToDoChange})
      : super(key: key);

  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('clicked on Todo Item');
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white38,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : null)),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () async {
              //print('delete item');
              bool? deleteConfirmed =
                  await DeleteDilogBox.showDeleteDilog(context);
              if (deleteConfirmed == true) {
                //delete operation
                onDeleteItem(todo.id);

                // Dismiss the dialog box
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }
}
