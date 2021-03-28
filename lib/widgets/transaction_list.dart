import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 140,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/waiting.png',width: 50,
                  fit: BoxFit.contain,
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(transactions[index].date),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
