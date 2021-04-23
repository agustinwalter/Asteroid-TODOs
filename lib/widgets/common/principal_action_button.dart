import 'package:flutter/material.dart';

class PrincipalActionButton extends StatelessWidget {
  const PrincipalActionButton({
    Key key,
    this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.deepOrange,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 22)),
          ),
        ),
      ],
    );
  }
}
