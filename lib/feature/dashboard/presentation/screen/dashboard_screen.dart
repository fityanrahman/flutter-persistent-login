import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:persistent_login/feature/auth/presentation/bloc/auth_event.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome user'),
            SizedBox(height: 24),
            MaterialButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogOut());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
