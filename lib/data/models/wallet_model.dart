import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  const WalletModel({
    required this.uid,
    required this.balance,
    required this.bonusBalance,
    required this.updatedAt,
  });

  final String uid;
  final double balance;
  final double bonusBalance;
  final DateTime updatedAt;

  factory WalletModel.fromJson(Map<String, dynamic> json, String documentId) {
    return WalletModel(
      uid: documentId,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      bonusBalance: (json['bonusBalance'] as num?)?.toDouble() ?? 0,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'bonusBalance': bonusBalance,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  WalletModel copyWith({double? balance, double? bonusBalance, DateTime? updatedAt}) {
    return WalletModel(
      uid: uid,
      balance: balance ?? this.balance,
      bonusBalance: bonusBalance ?? this.bonusBalance,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
