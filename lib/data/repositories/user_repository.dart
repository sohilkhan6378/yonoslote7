import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('users');

  Future<UserModel?> fetchUser(String uid) async {
    final doc = await _collection.doc(uid).get();
    if (!doc.exists) {
      return null;
    }
    return UserModel.fromJson(doc.data()!, doc.id);
  }

  Future<void> upsertUser(UserModel user) {
    return _collection.doc(user.uid).set(user.toJson(), SetOptions(merge: true));
  }

  Stream<UserModel?> watchUser(String uid) {
    return _collection.doc(uid).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return UserModel.fromJson(snapshot.data()!, snapshot.id);
    });
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final query = await _collection.get();
    return query.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}
