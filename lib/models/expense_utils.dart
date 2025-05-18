import 'expenseState.dart';

double sumExpenses(List<Expense> expenses) {
  return expenses.fold(0.0, (total, item) => total + item.amount);
}