import 'package:flutter/material.dart';
import 'expens_model.dart';

class ExpensItem extends StatelessWidget{
  const ExpensItem({super.key,required this.expens});

  final ExpenseModel expens;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expens.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),),
            const SizedBox(height: 5,),
            Row(
              children: [
                Text('Rs. ${expens.amount.toString()}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expens.category]),
                    const SizedBox(width: 5,),
                    Text(expens.dateformatter),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );

  }
}