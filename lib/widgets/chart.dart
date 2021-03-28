import 'package:flutter/material.dart';

import 'package:expense_note/models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  double get maxAmount {
    return groupedTransactionValues.fold(0.0, (sum, current) {
      return sum + current['amount'];
    });
  }

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month && tx.date.year == weekDay.year) {
          sum += tx.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': sum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((tx) {
          return ChartBar(
            tx['day'],
            tx['amount'],
            maxAmount == 0.0 ? 0.0 : tx['amount'] / maxAmount,
          );
        }).toList(),
      ),
    );
  }
}
