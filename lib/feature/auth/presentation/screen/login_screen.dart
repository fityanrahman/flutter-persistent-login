import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Form(
            child: Column(
              spacing: 16,
              children: [
                TextField(decoration: InputDecoration(hintText: 'Username')),
                TextField(decoration: InputDecoration(hintText: 'Password')),
                MaterialButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
