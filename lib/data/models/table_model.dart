import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  const TableModel({
    required this.id,
    required this.gameType,
    required this.entryFee,
    required this.maxPlayers,
    required this.players,
    required this.state,
    required this.createdAt,
  });

  final String id;
  final String gameType;
  final double entryFee;
  final int maxPlayers;
  final List<String> players;
  final String state;
  final DateTime createdAt;

  factory TableModel.fromJson(Map<String, dynamic> json, String id) {
    return TableModel(
      id: id,
      gameType: json['gameType'] as String,
      entryFee: (json['entryFee'] as num).toDouble(),
      maxPlayers: json['maxPlayers'] as int,
      players: List<String>.from(json['players'] as List<dynamic>? ?? []),
      state: json['state'] as String? ?? 'waiting',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameType': gameType,
      'entryFee': entryFee,
      'maxPlayers': maxPlayers,
      'players': players,
      'state': state,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
