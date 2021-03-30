import 'package:expense_note/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function handlerRemoveTransaction,
  }) : _transaction = transaction, _handlerRemoveTransaction = handlerRemoveTransaction, super(key: key);

  final Transaction _transaction;
  final Function _handlerRemoveTransaction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$ ${_transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd hh:mm:dd').format(_transaction.date),
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: mediaQuery.size.width > 400
            ? TextButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          style: TextButton.styleFrom(
            primary: Theme.of(context).errorColor,
          ),
          onPressed: () {
            _handlerRemoveTransaction(_transaction.id);
          },
        )
            : IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () {
            _handlerRemoveTransaction(_transaction.id);
          },
        ),
      ),
    );
  }
}
