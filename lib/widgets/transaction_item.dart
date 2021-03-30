import 'dart:math';

import 'package:expense_note/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function handlerRemoveTransaction,
  })   : _transaction = transaction,
        _handlerRemoveTransaction = handlerRemoveTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function _handlerRemoveTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const List<Color> availableColors = [Colors.red, Colors.blue, Colors.green, Colors.amber, Colors.purple];

    _bgColor = availableColors[Random().nextInt(availableColors.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      key: widget.key,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$ ${widget._transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget._transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd hh:mm:dd').format(widget._transaction.date),
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
                  widget._handlerRemoveTransaction(widget._transaction.id);
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  widget._handlerRemoveTransaction(widget._transaction.id);
                },
              ),
      ),
    );
  }
}
