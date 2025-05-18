import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth_widget.dart';
import 'package:workshop/models/expenseState.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(context) {
    return Consumer<ExpensesState>(

      builder: (context, state, child) {
        return Container(
          color: Color(0xffF2D3AC),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Travel Expenses App",
                  style: TextStyle(
                    color: Color(0xff401201),
                    fontSize: 22,
                  ),
                ),
                AuthWidget(),
              ],
            ),
          ),
        );
      }
    );
  }
}