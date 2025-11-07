import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType {
  deposit,
  withdraw,
  entryFee,
  prize,
  adjustment,
}

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.uid,
    required this.type,
    required this.amount,
    required this.status,
    required this.meta,
    required this.createdAt,
  });

  final String id;
  final String uid;
  final TransactionType type;
  final double amount;
  final String status;
  final Map<String, dynamic> meta;
  final DateTime createdAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) {
    return TransactionModel(
      id: id,
      uid: json['uid'] as String,
      type: TransactionType.values.firstWhere(
        (element) => element.name == json['type'],
        orElse: () => TransactionType.deposit,
      ),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String? ?? 'pending',
      meta: Map<String, dynamic>.from(json['meta'] as Map? ?? {}),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'type': type.name,
      'amount': amount,
      'status': status,
      'meta': meta,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
