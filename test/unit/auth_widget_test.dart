import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:workshop/auth_widget.dart';

void main() {
  testWidgets('Login Form renders and submits', (WidgetTester tester) async {
    final email = "test@example.com";
    final password = "password123";

    final mockUser = MockUser(
      isAnonymous: false,
      uid: 'abc123',
      email: email,
    );

    final mockAuth = MockFirebaseAuth(mockUser: mockUser);

    await tester.pumpWidget(MaterialApp(
      home: AuthWidget(auth: mockAuth),
    ));

    // now user switches to logn form by clicking on the text Login
    await tester.tap(find.text('Login').at(0));
    await tester.pump();

    // then the user enters email and password
    await tester.enterText(find.byType(TextField).at(0), email);
    await tester.enterText(find.byType(TextField).at(1), password);

    // then taps login button
    await tester.tap(find.text('Login').at(1));
    await tester.pump();

    // Expect login to have happened (no erros thorwn)
    expect(mockAuth.currentUser?.email, email);
  });
}