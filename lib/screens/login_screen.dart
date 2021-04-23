import 'package:asteroid_todo/providers/user_provider.dart';
import 'package:asteroid_todo/widgets/common/one_line_textfield.dart';
import 'package:asteroid_todo/widgets/common/principal_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() => _loading = true);
    await Provider.of<UserProvider>(context, listen: false).signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
          shrinkWrap: true,
          children: <Widget>[
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Logo
                  Image.asset(
                    'assets/img/logo.png',
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 28),
                  // Login form
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            '¡Bienvenid@ a Asteroid Todo!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 28),
                          OneLineTextField(
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            labelText: 'Email (user@example.com)',
                            icon: Icons.email_outlined,
                            focusColor: Colors.deepOrange,
                          ),
                          const SizedBox(height: 16),
                          OneLineTextField(
                            labelText: 'Contraseña (12345678)',
                            icon: Icons.vpn_key,
                            focusColor: Colors.deepOrange,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 16),
                          if (_loading)
                            const Center(child: CircularProgressIndicator())
                          else
                            PrincipalActionButton(
                              onPressed: () => _signIn(context),
                              text: 'Ingresar',
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
