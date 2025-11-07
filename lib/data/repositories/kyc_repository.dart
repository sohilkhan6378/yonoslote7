import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/kyc_model.dart';

class KycRepository {
  KycRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('kyc');

  Future<KycModel?> fetchKyc(String uid) async {
    final doc = await _collection.doc(uid).get();
    if (!doc.exists) {
      return null;
    }
    return KycModel.fromJson(doc.data()!, doc.id);
  }

  Future<void> submitKyc(KycModel kyc) {
    return _collection.doc(kyc.uid).set(kyc.toJson(), SetOptions(merge: true));
  }

  Stream<List<KycModel>> watchPending() {
    return _collection
        .where('status', isEqualTo: 'pending')
        .orderBy('updatedAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => KycModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}
