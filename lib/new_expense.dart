import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:workshop/models/expense_model.dart';
// import 'package:workshop/expenses.dart';
import 'package:travel_expenses_app/models/expenseState.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _chosenDate;

  Category _selectedCategory = Category.food;

  final _dateFormatter = DateFormat.yMd();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _chosenDate = selectedDate;
    });
  }

  // void addExpense() {
  //   final newExpense = Expense(
  //     name: _titleController.text,
  //     amount: double.parse(_amountController.text),
  //     date: _chosenDate!,
  //     category: _selectedCategory,
  //   );
  //   widget.onAddExpense(newExpense);
  //   Navigator.of(context).pop();
  // }

  void _saveExpense() {
    bool isTitleValid = _titleController.text.isEmpty ? false : true;
    bool isAmountValid = double.tryParse(_amountController.text) == null ? false : true;
    bool isDateValid = _chosenDate == null ? false : true;
    if (!isTitleValid) {
      showDialog(
        context: context,
        builder:
            (diaglogContext) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please enter a Name for the Expense'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(diaglogContext);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    } else if (!isAmountValid) {
      showDialog(
        context: context,
        builder:
            (diaglogContext) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please enter a valid Amount'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(diaglogContext);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    } else if (!isDateValid) {
      showDialog(
        context: context,
        builder:
            (diaglogContext) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please select a Date'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(diaglogContext);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    } else {
      // addExpense();
      widget.onAddExpense(
        Expense(
          name: _titleController.text,
          amount: double.parse(_amountController.text),
          date: _chosenDate!,
          category: _selectedCategory,
          ),
      );
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 40,
            decoration: InputDecoration(label: Text('Expense Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 40,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Expense Amount'),
                    prefixText: '\$',
                  ),
                ),
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Text(
                    _chosenDate == null
                        ? 'Pick Date'
                        : _dateFormatter.format(_chosenDate!),
                  ),
                  IconButton(
                    onPressed: _openDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text('Category:'),
              SizedBox(width: 20),
              DropdownButton<Category>(
                value: _selectedCategory,
                items:
                    Category.values.map((category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                onChanged: (newCategory) {
                  setState(() {
                    _selectedCategory = newCategory!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text("Save Expense"),
              ),
              SizedBox(width: 30),
              ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}
