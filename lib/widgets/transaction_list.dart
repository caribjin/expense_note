import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _handlerRemoveTransaction;

  TransactionList(this._transactions, this._handlerRemoveTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 140,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 30),
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
                return Card(
                  margin: EdgeInsets.symmetric(
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
                            '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd hh:mm:dd').format(_transactions[index].date),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () {
                        _handlerRemoveTransaction(_transactions[index].id);
                      },
                     ),
                  ),
                );
              },
            ),
    );
  }
}
