import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/providers/todo_provider.dart';
import 'package:asteroid_todo/providers/user_provider.dart';
import 'package:asteroid_todo/widgets/todos/todo_card.dart';
import 'package:asteroid_todo/widgets/todos/todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => TodoDialog(
        title: 'Add new TODO',
        buttonText: 'Add!',
        onButtonClick: (Todo todo) {
          Provider.of<TodosProvider>(context, listen: false).addTodo(todo);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodosProvider>(context, listen: false).getAllTodos();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Your TODOs'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Consumer<TodosProvider>(builder: (_, TodosProvider todosProvider, __) {
        final List<Todo> todos = todosProvider.todos;
        if (todos.isEmpty) {
          return const Center(
            child: Text('There are no TODOs yet, create one.'),
          );
        }

        return ListView.builder(
          itemCount: todos.length,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 136),
          itemBuilder: (_, int index) => TodoCard(todo: todos[index]),
        );
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Search todo
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.search),
            mini: true,
          ),
          const SizedBox(height: 16),
          // Add todo
          FloatingActionButton(
            onPressed: () => _showAddTodoDialog(context),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
