import 'package:flutter_test/flutter_test.dart';
import 'package:travel_expenses_app/models/expenseState.dart';

void main() {
  test('addExpense should add to the list', () {
    final state = ExpensesState();
    final expense = Expense(
      name: 'Lunch',
      amount: 12.0,
      date: DateTime.now(),
      category: Category.food,
    );

    state.addListener(() {
      expect(state.expenses.contains(expense), true);
    });
    
    state.addExpense(expense);

  });

  test('removeExpense should remove from the list', () {
    final state = ExpensesState();
    final expense = Expense(
      name: 'Taxi',
      amount: 15.0,
      date: DateTime.now(),
      category: Category.experience,
    );

    state.addExpense(expense);
    
    state.addListener(() {
      expect(state.expenses.contains(expense), false);
    });

    state.removeExpense(expense);
  });
}