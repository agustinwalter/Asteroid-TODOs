import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/providers/todo_provider.dart';
import 'package:asteroid_todo/widgets/todos/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        _search(_searchController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String title) async {
    Provider.of<TodosProvider>(context, listen: false).searchByTitle(title);
  }

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Consumer<TodosProvider>(
        builder: (_, TodosProvider todosProvider, __) => _body(
          todosProvider.searchedTodo,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back),
              mini: true,
            ),
            const SizedBox(width: 8),
            FloatingActionButton.extended(
              onPressed: () {},
              heroTag: 'search',
              label: SizedBox(
                width: sWidth - 128,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Search a TODO',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(Todo searchedTodo) {
    if (_searchController.text.isEmpty) {
      return const SizedBox.shrink();
    }
    if (searchedTodo == null) {
      return const Center(child: Text('Nothing found 😢'));
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
        child: TodoCard(todo: searchedTodo),
      ),
    );
  }
}
