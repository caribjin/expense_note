import 'dart:ui';

import 'package:expense_note/models/transaction.dart';
import 'package:expense_note/widgets/chart.dart';
import 'package:expense_note/widgets/new_transaction.dart';
import 'package:expense_note/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

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
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      _transactions.add(
        Transaction(
          id: 't$i',
          title: 'Title $i',
          amount: 10000.20,
          date: DateTime.now(),
        ),
      );
    }
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.add(Duration(days: 7)).isAfter(DateTime.now());
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: 't${_transactions.length + 1}',
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Add Transaction',
          onPressed: () => _showNewTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
              child: TransactionList(_transactions, _removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add Transaction',
        // backgroundColor: Colors.orangeAccent,
        onPressed: () => _showNewTransaction(context),
      ),
    );
  }
}
