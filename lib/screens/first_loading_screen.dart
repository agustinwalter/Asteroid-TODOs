import 'package:flutter/material.dart';

class FirstLoadingScreen extends StatelessWidget {
  const FirstLoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
