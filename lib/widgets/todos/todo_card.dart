import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/providers/todo_provider.dart';
import 'package:asteroid_todo/widgets/common/error_toast.dart';
import 'package:asteroid_todo/widgets/todos/todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key key, @required this.todo}) : super(key: key);

  final Todo todo;

  void _showEditTodoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => TodoDialog(
        title: 'Edit TODO',
        buttonText: 'Save!',
        todo: todo,
        onButtonClick: (Todo todo) => _editTodo(context, todo),
      ),
    );
  }

  Future<void> _editTodo(BuildContext context, Todo todo) async {
    if (todo.title.isEmpty || todo.description.isEmpty) {
      showErrorToast('Both title and description are required.');
      return;
    }
    try {
      await Provider.of<TodosProvider>(context, listen: false).editTodo(todo);
      Navigator.pop(context);
    } on AlreadyExistsException catch (e) {
      showErrorToast(e.message);
    } catch (e) {
      showErrorToast('Something went wrong, please try again.');
      print(e);
    }
  }

  Future<void> _deleteTodo(BuildContext context) async {
    try {
      await Provider.of<TodosProvider>(context, listen: false).deleteTodo(todo.uid);
    } catch (e) {
      showErrorToast('Something went wrong, please try again.');
      print(e);
    }
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
            onTap: () => _showEditTodoDialog(context),
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
