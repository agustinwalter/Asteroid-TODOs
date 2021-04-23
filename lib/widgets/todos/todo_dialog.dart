import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/widgets/common/one_line_textfield.dart';
import 'package:asteroid_todo/widgets/common/principal_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoDialog extends StatefulWidget {
  const TodoDialog({
    Key key,
    @required this.title,
    @required this.buttonText,
    @required this.onButtonClick,
    this.todo,
  }) : super(key: key);

  final String title;
  final String buttonText;
  final void Function(Todo) onButtonClick;
  final Todo todo;

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      _titleController.text = widget.todo.title;
      _descriptionController.text = widget.todo.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          OneLineTextField(
            textInputAction: TextInputAction.next,
            labelText: 'Title',
            focusColor: Colors.deepOrange,
            controller: _titleController,
          ),
          const SizedBox(height: 16),
          OneLineTextField(
            labelText: 'Description',
            focusColor: Colors.deepOrange,
            textInputAction: TextInputAction.newline,
            controller: _descriptionController,
          ),
          const SizedBox(height: 16),
          PrincipalActionButton(
            onPressed: () {
              if (widget.todo != null) {
                widget.onButtonClick(
                  widget.todo.copyWith(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    lastModified: Timestamp.now(),
                  ),
                );
              } else {
                widget.onButtonClick(
                  Todo(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    lastModified: Timestamp.now(),
                  ),
                );
              }
            },
            text: widget.buttonText,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
    );
  }
}
