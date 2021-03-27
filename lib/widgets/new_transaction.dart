import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final Function handlerAddTransaction;

  NewTransaction(this.handlerAddTransaction);

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
            ),
            TextField(
              controller: _amountController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                handlerAddTransaction(_titleController.text, double.parse(_amountController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
