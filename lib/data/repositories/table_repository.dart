import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/table_model.dart';

class TableRepository {
  TableRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('tables');

  Stream<List<TableModel>> watchActiveTables() {
    return _collection
        .where('state', whereIn: ['waiting', 'dealing', 'inRound'])
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TableModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<TableModel> fetchTable(String id) async {
    final doc = await _collection.doc(id).get();
    return TableModel.fromJson(doc.data()!, doc.id);
  }

  Future<void> updateTableState(String id, String state) {
    return _collection.doc(id).update({'state': state});
  }
}
