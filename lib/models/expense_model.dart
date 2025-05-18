import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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

//custom icons for each of the Categories
const categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.stay: Icons.hotel,
  Category.experience: Icons.snowboarding,
  Category.shopping: Icons.shopping_basket,
};

final formatter = DateFormat.yMd(); //a date formatter to format the date of the expense

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
