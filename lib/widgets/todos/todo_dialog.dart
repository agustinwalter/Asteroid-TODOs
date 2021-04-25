import 'dart:io';
import 'package:asteroid_todo/models/todo.dart';
import 'package:asteroid_todo/widgets/common/one_line_textfield.dart';
import 'package:asteroid_todo/widgets/common/principal_action_button.dart';
import 'package:asteroid_todo/widgets/common/secondary_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker picker = ImagePicker();

  File _prevImage;

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

  void _onPrincipalButtonClick() {
    if (widget.todo != null) {
      widget.onButtonClick(
        widget.todo.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          localImage: _prevImage,
          lastModified: Timestamp.now(),
        ),
      );
    } else {
      widget.onButtonClick(
        Todo(
          title: _titleController.text,
          description: _descriptionController.text,
          localImage: _prevImage,
          lastModified: Timestamp.now(),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _prevImage = File(pickedFile.path);
      }
    });
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
          const SizedBox(height: 8),
          _image(),
          const SizedBox(height: 8),
          SecondaryActionButton(onPressed: _pickImage, text: 'Upload image!'),
          const SizedBox(height: 8),
          PrincipalActionButton(
            onPressed: _onPrincipalButtonClick,
            text: widget.buttonText,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
    );
  }

  Widget _image() {
    if (_prevImage != null) {
      return Image.file(
        _prevImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
    if (widget.todo?.imageUrl != null) {
      return Image.network(
        widget.todo?.imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
    return const SizedBox.shrink();
  }
}
