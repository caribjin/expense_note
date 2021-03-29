import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _label;
  final double _amount;
  final double _percent;

  ChartBar(this._label, this._amount, this._percent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 16,
          child: FittedBox(
            child: Text('\$${_amount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
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
                heightFactor: _percent,
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
        Text(_label.substring(0, 1)),
      ],
    );
  }
}
