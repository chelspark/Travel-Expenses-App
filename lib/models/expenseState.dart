import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ExpensesState extends ChangeNotifier {

  final List<Expense> _expenses = [];

  List<Expense> get expenses => List.unmodifiable(_expenses);

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _expenses.remove(expense);
    notifyListeners();
  }

  void updateExpense(String id, Expense updatedExpense) {
    final index = _expenses.indexWhere((expense) => expense.id == id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  void removeExpenseById(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  Expense? getExpenseById(String id) {
    try {
      return _expenses.firstWhere((expense) => expense.id == id);
    } catch (e) {
      return null;
    }
    // return _expenses.firstWhere((expense) => expense.id == id, orElse: () => null);
  }

}

/* Termianl Commands for package uuid
      flutter pub add uuid
  uuid is a library for generating universally unique identifiers (UUIDs).
  It is used to create unique IDs for each expense.
 */
/* Terminal Commands for package intl
    flutter pub add intl

  intl defines the DateFormat, NumberFormat, and BidiFormatter classes.
*/

const uuid = Uuid();

enum Category { food, stay, experience, shopping }

final formatter = DateFormat.yMd(); //a date formatter to format the date of the expense

//custom icons for each of the Categories
final categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.stay: Icons.hotel,
  Category.experience: Icons.snowboarding,
  Category.shopping: Icons.shopping_basket,
};

class Expense {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Enum category;

  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}