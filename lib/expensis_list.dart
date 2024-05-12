import 'package:expensetracker/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/expens_model.dart';

class ExpensisList extends StatelessWidget {
  const ExpensisList(
      {super.key, required this.expens, required this.onRemoveExpense});
  final List<ExpenseModel> expens;
  final Function(ExpenseModel removeExpense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expens.length,
        itemBuilder: (ctx, idx) => Dismissible(
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            ),

            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,vertical: 8),
          ),
          key: ValueKey(expens[idx]),
          onDismissed: (direction) {
            onRemoveExpense(expens[idx]);
          },
          child: ExpensItem(expens: expens[idx]),
        ),
      );
  }
}
