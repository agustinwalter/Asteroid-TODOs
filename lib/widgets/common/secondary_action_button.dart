import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
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
              onPrimary: Colors.deepOrange,
              primary: Colors.white,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              side: const BorderSide(width: 1, color: Colors.deepOrange),
              elevation: 0,
            ),
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 22)),
          ),
        ),
      ],
    );
  }
}
