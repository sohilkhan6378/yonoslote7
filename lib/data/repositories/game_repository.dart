import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game_round_model.dart';

class GameRepository {
  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('gameRounds');

  Future<void> saveRound(GameRoundModel round) {
    return _collection.doc(round.id).set(round.toJson());
  }

  Stream<GameRoundModel?> watchRound(String roundId) {
    return _collection.doc(roundId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return GameRoundModel.fromJson(snapshot.data()!, snapshot.id);
    });
  }
}
