import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percent;

  ChartBar(this.label, this.amount, this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${amount.toStringAsFixed(0)}'),
        SizedBox(height: 5),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label.substring(0, 1)),
      ],
    );
  }
}
