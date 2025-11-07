import 'package:cloud_firestore/cloud_firestore.dart';

class GameRoundModel {
  const GameRoundModel({
    required this.id,
    required this.tableId,
    required this.deckSeed,
    required this.deals,
    required this.turnIndex,
    required this.discardPile,
    required this.winnerUid,
    required this.settled,
    required this.createdAt,
  });

  final String id;
  final String tableId;
  final int deckSeed;
  final Map<String, List<String>> deals;
  final int turnIndex;
  final List<String> discardPile;
  final String? winnerUid;
  final bool settled;
  final DateTime createdAt;

  factory GameRoundModel.fromJson(Map<String, dynamic> json, String id) {
    final dealsMap = Map<String, dynamic>.from(json['deals'] as Map? ?? {});
    return GameRoundModel(
      id: id,
      tableId: json['tableId'] as String,
      deckSeed: json['deckSeed'] as int,
      deals: dealsMap.map((key, value) => MapEntry(key, List<String>.from(value as List))),
      turnIndex: json['turnIndex'] as int? ?? 0,
      discardPile: List<String>.from(json['discardPile'] as List<dynamic>? ?? []),
      winnerUid: json['winnerUid'] as String?,
      settled: json['settled'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tableId': tableId,
      'deckSeed': deckSeed,
      'deals': deals,
      'turnIndex': turnIndex,
      'discardPile': discardPile,
      'winnerUid': winnerUid,
      'settled': settled,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
