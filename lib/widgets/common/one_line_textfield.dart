import 'package:flutter/material.dart';

class OneLineTextField extends StatelessWidget {
  const OneLineTextField({
    Key key,
    this.controller,
    this.textInputAction,
    this.onEditingComplete,
    this.labelText,
    this.icon,
    this.focusColor,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final void Function() onEditingComplete;
  final String labelText;
  final IconData icon;
  final Color focusColor;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: focusColor),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : 5,
        minLines: 1,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          prefixIcon: icon != null ? Icon(icon) : null,
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: focusColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
