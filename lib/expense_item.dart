import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:workshop/models/expense_model.dart';
import 'package:travel_expenses_app/models/expenseState.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.eachExpense});

  final Expense eachExpense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eachExpense.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Expense'),
                          content: const Text('Are you sure you want to delete this expense?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ExpensesState>().removeExpenseById(eachExpense.id);
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red),)
                            )
                          ],
                        )
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    iconSize: 20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${eachExpense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[eachExpense.category]),
                    Text(
                      eachExpense.formattedDate,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
