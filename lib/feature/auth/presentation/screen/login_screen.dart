import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    debugPrint('Username: $username');
    debugPrint('Password: $password');

    context.read<AuthBloc>().add(
      AuthLogIn(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  controller: _usernameController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Username is required' : null,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Password is required' : null,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                MaterialButton(onPressed: _submit, child: Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
