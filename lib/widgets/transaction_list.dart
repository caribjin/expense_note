import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _handlerRemoveTransaction;

  TransactionList(this._transactions, this._handlerRemoveTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transaction',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/waiting.png',
                width: 50,
                fit: BoxFit.contain,
              ),
            ],
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(
                transaction: _transactions[index],
                handlerRemoveTransaction: _handlerRemoveTransaction,
              );
            },
          );
  }
}
