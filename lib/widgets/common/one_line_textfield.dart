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
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          prefixIcon: Icon(icon),
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: focusColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
