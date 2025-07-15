import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                context.go('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
