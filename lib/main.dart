import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth_screen.dart';
import 'package:workshop/expenses.dart';
import 'package:workshop/firebase_options.dart';
import 'package:workshop/models/expenseState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

var myLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 161, 109, 170),
);

var myDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 25, 93, 86),
  brightness: Brightness.dark
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpensesState(),
      child: MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: myDarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myDarkColorScheme.onPrimaryContainer,
            foregroundColor: myDarkColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: myDarkColorScheme.secondaryContainer,
          ),
          textTheme: const TextTheme().copyWith(
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: myDarkColorScheme.onPrimaryContainer,
            ),
            headlineSmall: TextStyle(
              fontSize: 15,
              color: myDarkColorScheme.onSecondaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: myLightColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myLightColorScheme.onPrimaryContainer,
            foregroundColor: myLightColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: myLightColorScheme.primaryContainer,
          ),
          textTheme: const TextTheme().copyWith(
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: myLightColorScheme.onPrimaryContainer,
            ),
            headlineSmall: TextStyle(
              fontSize: 15,
              color: myLightColorScheme.onSecondaryContainer,
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              return user != null ? const Expenses() : const AuthScreen();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        )
      ),
    )
  );
}

//Expenses()
