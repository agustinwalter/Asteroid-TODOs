import 'package:asteroid_todo/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus todos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
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
            onPressed: () {},
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
