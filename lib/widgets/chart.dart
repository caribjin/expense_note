import 'package:flutter/material.dart';

import 'package:expense_note/models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  const Chart(this._recentTransactions);

  double get maxAmount {
    return groupedTransactionValues.fold(0.0, (sum, current) {
      return sum + current['amount'];
    });
  }

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;

      for (var tx in _recentTransactions) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month && tx.date.year == weekDay.year) {
          sum += tx.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': sum};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx['day'],
                tx['amount'],
                maxAmount == 0.0 ? 0.0 : tx['amount'] / maxAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
