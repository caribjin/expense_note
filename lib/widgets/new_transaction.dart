import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final Function handlerAddTransaction;

  NewTransaction(this.handlerAddTransaction);

  void _handleSubmit() {
    String title = _titleController.text;
    String amount = _amountController.text;

    if (title.isEmpty || amount.isEmpty) return;

    if (double.tryParse(amount) == null) {
      print('잘못된 금액 값입니다');
      return;
    }

    handlerAddTransaction(title, double.parse(amount));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // color: Colors.green,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _amountController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            TextButton(
              child: Text('ADD'),
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
