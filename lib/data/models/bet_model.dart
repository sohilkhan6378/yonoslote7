import 'package:cloud_firestore/cloud_firestore.dart';

class BetModel {
  const BetModel({
    required this.id,
    required this.tableId,
    required this.uid,
    required this.amount,
    required this.placedAt,
  });

  final String id;
  final String tableId;
  final String uid;
  final double amount;
  final DateTime placedAt;

  factory BetModel.fromJson(Map<String, dynamic> json, String id) {
    return BetModel(
      id: id,
      tableId: json['tableId'] as String,
      uid: json['uid'] as String,
      amount: (json['amount'] as num).toDouble(),
      placedAt: (json['placedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tableId': tableId,
      'uid': uid,
      'amount': amount,
      'placedAt': Timestamp.fromDate(placedAt),
    };
  }
}
