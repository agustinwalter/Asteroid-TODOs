import 'package:asteroid_todo/providers/todo_provider.dart';
import 'package:asteroid_todo/providers/user_provider.dart';
import 'package:asteroid_todo/screens/first_loading_screen.dart';
import 'package:asteroid_todo/screens/init_error_screen.dart';
import 'package:asteroid_todo/screens/login_screen.dart';
import 'package:asteroid_todo/screens/todos_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<TodosProvider>(create: (_) => TodosProvider()),
      ],
      child: const AsteroidTodo(),
    ),
  );
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

  void _initUser(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).initUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (_, AsyncSnapshot<FirebaseApp> snapshot) {
        if (snapshot.hasError) {
          return const InitErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          _initUser(context);

          return Consumer<UserProvider>(
            builder: (_, UserProvider userProvider, __) {
              if (userProvider.user != null) {
                // User is logged!
                return const TodosScreen();
              }

              return const LoginScreen();
            },
          );
        }

        return const FirstLoadingScreen();
      },
    );
  }
}
