import 'package:flutter/material.dart';
import 'package:expensetracker/expens_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddexpence});

  final Function(ExpenseModel newexpence) onaddexpence;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _textcontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  Category _selectedcategory = Category.work;
  DateTime? _selecteddate;

  void _presentdatepicker() async {
    var now = DateTime.now();
    var firstdate = DateTime(now.year - 1, now.month, now.day);
    final presentdate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstdate,
      lastDate: now,
    );
    setState(() {
      _selecteddate = presentdate;
    });
  }

  @override
  void dispose() {
    _textcontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _submitexpesisdata() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final enteredAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_textcontroller.text.trim().isEmpty ||
        enteredAmountInvalid ||
        _selecteddate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('please make sure to input valid data'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('okay')),
                ],
              ));
      return;
    }
    widget.onaddexpence(ExpenseModel(
        title: _textcontroller.text,
        amount: enteredAmount,
        dateTime: _selecteddate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,25,16,16),
      child: Column(
        children: [
          TextField(
            controller: _textcontroller,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('title'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'Rs. ',
                    label: Text('amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selecteddate == null
                      ? 'no date selected '
                      : formatter.format(_selecteddate!)),
                  IconButton(
                    onPressed: _presentdatepicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedcategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category.name.toString())))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedcategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancle')),
              ElevatedButton(
                  onPressed: _submitexpesisdata, child: const Text('submit')),
            ],
          )
        ],
      ),
    );
  }
}
