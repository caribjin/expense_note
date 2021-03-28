import 'dart:math';

import 'package:flutter/material.dart';

import 'new_transaction.dart';
import 'transaction_list.dart';

import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();

    // for (int i = 0; i < 20; i++) {
    //   transactions.add(Transaction(
    //     id: 't$i',
    //     title: 'Title $i',
    //     amount: 100.12,
    //     date: DateTime.now(),
    //   ));
    // }
  }

  void _addTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: 't${transactions.length + 1}',
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(transactions),
      ],
    );
  }
}
