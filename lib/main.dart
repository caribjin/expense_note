import 'dart:ui';

import 'package:expense_note/models/transaction.dart';
import 'package:expense_note/widgets/chart.dart';
import 'package:expense_note/widgets/new_transaction.dart';
import 'package:expense_note/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            // fontWeight: FontWeight.bold,
            // fontSize: 18,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();

    // for (int i = 0; i < 20; i++) {
    //   transactions.add(
    //     Transaction(
    //       id: 't$i',
    //       title: 'Title $i',
    //       amount: 100,
    //       date: DateTime.now(),
    //     ),
    //   );
    // }
  }

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.add(Duration(days: 7)).isAfter(DateTime.now());
    }).toList();
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

    Navigator.of(context).pop();
  }

  void _showNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add Transaction',
            onPressed: () => _showNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Transaction',
        // backgroundColor: Colors.orangeAccent,
        onPressed: () => _showNewTransaction(context),
      ),
    );
  }
}
