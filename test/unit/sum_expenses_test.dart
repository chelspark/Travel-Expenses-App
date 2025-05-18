import 'package:flutter_test/flutter_test.dart';
import 'package:workshop/models/expenseState.dart';
import 'package:workshop/models/expense_utils.dart';

void main() {
  group('sumExpenses', () {
    test('returns 0 for empty list', () {
      expect(sumExpenses([]), 0.0);
    } );

    test('returns amount for one expense', () {
      final expenses = [
        Expense(name: 'Coffee', amount: 4.5, date: DateTime.now(), category: Category.food),
      ];
      expect(sumExpenses(expenses), 4.5);
    } );

    test('returns correct sum for multiple expenses', () {
      final expenses = [
        Expense(name: 'Coffee', amount: 4.5, date: DateTime.now(), category: Category.food),
        Expense(name: 'Lunch', amount: 20.0, date: DateTime.now(), category: Category.food),
        Expense(name: 'Taxi', amount: 15.5, date: DateTime.now(), category: Category.experience),
      ];
      expect(sumExpenses(expenses), 40.0);
    } );
  });
}