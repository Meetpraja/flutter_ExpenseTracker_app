import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {food, movie, travel, work}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.movie : Icons.movie,
  Category.travel : Icons.flight_takeoff,
  Category.work : Icons.work,
};

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
}) : id = uuid.v4() ;

  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  String get dateformatter {
    return formatter.format(dateTime);
}
}

class ExpenseBucket{

  const ExpenseBucket({required this.category,required this.expenses});
  ExpenseBucket.forCategory(
      List<ExpenseModel> allExpenses,
      this.category
      ): expenses = allExpenses
      .where((expense) => expense.category == category)
      .toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalexpense{
    double sum = 0;
    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }

}