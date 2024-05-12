import 'package:expensetracker/chart.dart';
import 'package:expensetracker/newexpense.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/expens_model.dart';
import 'package:expensetracker/expensis_list.dart';

class Expensis extends StatefulWidget {
  const Expensis({super.key});

  @override
  State<Expensis> createState() => _ExpensisState();
}

class _ExpensisState extends State<Expensis> {
  final List<ExpenseModel> _registeredexpensis = [
    ExpenseModel(
      title: 'flutter',
      amount: 4000,
      dateTime: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'cinema',
      amount: 500,
      dateTime: DateTime.now(),
      category: Category.movie,
    ),
  ];

  void _onaddexpence() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onaddexpence: _addnewexpense),
    );
  }

  void _addnewexpense(ExpenseModel expensis) {
    setState(() {
      _registeredexpensis.add(expensis);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final indexOfExpense = _registeredexpensis.indexOf(expense);
    setState(() {
      _registeredexpensis.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
          content:const Text('expense deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: (){
            setState(() {
              _registeredexpensis.insert(indexOfExpense, expense);
            });
          },
        ),

      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = const Center (
      child: Text('no expenses found. start adding new'),
    );
    if(_registeredexpensis.isNotEmpty){
      setState(() {
        mainWidget = ExpensisList(
          expens: _registeredexpensis,
          onRemoveExpense: _removeExpense,
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('expense tracker'),
        actions: [
          IconButton(
            onPressed: _onaddexpence,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredexpensis),
          Expanded(
            child: mainWidget,
          ),
        ],
      ),
    );
  }
}
