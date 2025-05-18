import 'package:flutter/material.dart';
// import 'package:workshop/models/expense_model.dart';
import 'package:travel_expenses_app/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:travel_expenses_app/models/expenseState.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    // required this.allExpenses,
    // required this.onRemoveExpense,
    // required this.addBackExpense,
  });

  // final List<Expense> allExpenses;
  // final void Function(Expense expense) onRemoveExpense;
  // final void Function(Expense expense) addBackExpense;

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpensesState>().expenses;

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (listContext, index) {
        final expense = expenses[index];

        return Dismissible(
          key: ValueKey(expense.id),
          onDismissed: (direction) {
            context.read<ExpensesState>().removeExpense(expense);

            final snackBar = SnackBar(
              content: const Text('Expense deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  context.read<ExpensesState>().addExpense(expense);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: ExpenseItem(eachExpense: expense),
        );
      },
    );
  }
}
