import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistent_login/main.dart';

void main() {
  testWidgets('App should start with login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that login screen is displayed initially
    expect(find.text('Login'), findsWidgets);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('App should navigate to dashboard after login', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for initial state to settle
    await tester.pumpAndSettle();

    // Find username and password fields
    final usernameField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).at(1);
    final loginButton = find.byType(MaterialButton);

    // Enter login credentials
    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpass');
    await tester.tap(loginButton);

    // Wait for authentication and navigation
    await tester.pumpAndSettle();

    // Verify dashboard is shown
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Welcome user'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
