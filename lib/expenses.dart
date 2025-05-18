import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth_widget.dart';
import 'package:workshop/expense_list.dart';
// import 'package:workshop/models/expense_model.dart';
import 'package:workshop/new_expense.dart';
import 'package:workshop/models/expenseState.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _Expenses();
}

class _Expenses extends State<Expenses> {
  // final List<Expense> _myExpenses = [
  //   Expense(
  //     name: 'Birthday Dinner',
  //     amount: 300,
  //     date: DateTime.now(),
  //     category: Category.food,
  //   ),
  //   Expense(
  //     name: 'Kayking tour',
  //     amount: 70,
  //     date: DateTime.now(),
  //     category: Category.experience,
  //   ),
  // ];

  void _openAddExpenseItemOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpenseToList
      )
    );
  }

  void _addExpenseToList(Expense expense) {
    Provider.of<ExpensesState>(context, listen: false).addExpense(expense);
  }

  // void _onRemoveExpense(Expense expense) {
  //   setState(() {
  //     _myExpenses.remove(expense);
  //   });
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Expenses'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseItemOverlay,
            icon: const Icon(Icons.add),
          ),
          LogoutWidget(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ExpenseList(
                // allExpenses: _myExpenses,
                // onRemoveExpense: _onRemoveExpense,
                // addBackExpense: _addExpenseToList,
                ),
              ),
            ],
        ),
      ),
    );
  }
}
