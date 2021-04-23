import 'package:asteroid_todo/screens/first_loading_screen.dart';
import 'package:asteroid_todo/screens/init_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AsteroidTodo());
}

class AsteroidTodo extends StatelessWidget {
  const AsteroidTodo({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asteroid Todo',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (_, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return const InitErrorScreen();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const Text('Ok!');
          }

          return const FirstLoadingScreen();
        },
      ),
    );
  }
}
