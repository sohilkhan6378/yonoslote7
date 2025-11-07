import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wallet_model.dart';

class WalletRepository {
  WalletRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('wallets');

  Future<WalletModel> fetchWallet(String uid) async {
    final doc = await _collection.doc(uid).get();
    if (!doc.exists) {
      final newWallet = WalletModel(
        uid: uid,
        balance: 0,
        bonusBalance: 0,
        updatedAt: DateTime.now(),
      );
      await _collection.doc(uid).set(newWallet.toJson());
      return newWallet;
    }
    return WalletModel.fromJson(doc.data()!, doc.id);
  }

  Future<void> updateBalance({required String uid, required double delta}) {
    return _firestore.runTransaction((transaction) async {
      final ref = _collection.doc(uid);
      final snapshot = await transaction.get(ref);
      final current = snapshot.exists
          ? WalletModel.fromJson(snapshot.data()!, snapshot.id)
          : WalletModel(
              uid: uid,
              balance: 0,
              bonusBalance: 0,
              updatedAt: DateTime.now(),
            );
      final updated = current.copyWith(
        balance:
            (current.balance + delta).clamp(0, double.infinity).toDouble(),
        updatedAt: DateTime.now(),
      );
      transaction.set(ref, updated.toJson());
    });
  }
}
