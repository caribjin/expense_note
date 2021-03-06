import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _handlerAddTransaction;

  NewTransaction(this._handlerAddTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _date = DateTime.now();

  void _handleSubmit() {
    String title = _titleController.text;
    String amount = _amountController.text;

    if (title.isEmpty || amount.isEmpty) return;

    if (double.tryParse(amount) == null) {
      print('잘못된 금액 값입니다');
      return;
    }

    widget._handlerAddTransaction(title, double.parse(amount), _date);
  }

  void _showDatePicker() async {
    DateTime? currentDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );

    if (currentDate == null) return;

    setState(() {
      _date = currentDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _amountController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(DateFormat.yMMMEd().format(_date)),
                  ),
                  TextButton(
                    child: Text('Choose Date'),
                    onPressed: () {
                      _showDatePicker();
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                _handleSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
