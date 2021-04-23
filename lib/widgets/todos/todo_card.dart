import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key key, @required this.todo}) : super(key: key);

  final Todo todo;

  void _deleteTodo(BuildContext context) {
    Provider.of<TodosProvider>(context, listen: false).deleteTodo(todo.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        actionExtentRatio: .16,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.transparent,
            icon: Icons.edit,
            foregroundColor: Colors.blueAccent,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.transparent,
            foregroundColor: Colors.redAccent,
            icon: Icons.delete,
            onTap: () => _deleteTodo(context),
          ),
        ],
        actionPane: const SlidableDrawerActionPane(),
      ),
    );
  }
}
