import 'package:flutter/foundation.dart';

class Transaction {
	final String id;
	final String title;
	final double amount;
	final DateTime date;

	const Transaction({
		required this.id,
		required this.title,
		required this.amount,
		required this.date
	});

	@override
	String toString() {
		return 'Transaction(id: $id, title: $title, amount: $amount, date: $date)';
	}

	factory Transaction.fromJson(Map<String, dynamic> json) {
		return Transaction(
			id: json['id'] as String,
			title: json['title'] as String,
			amount: json['amount'] as double,
			date: json['date'] as DateTime,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'title': title,
			'amount': amount,
			'date': date,
		};
	}	

Transaction copyWith({
		String? id,
		String? title,
		double? amount,
		DateTime? date,
	}) {
		return Transaction(
			id: id ?? this.id,
			title: title ?? this.title,
			amount: amount ?? this.amount,
			date: date ?? this.date,
		);
	}
}
