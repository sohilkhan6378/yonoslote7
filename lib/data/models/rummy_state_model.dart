/// Client-side snapshot of an in-progress Rummy round.
class RummyStateModel {
  const RummyStateModel({
    required this.roundId,
    required this.playerHands,
    required this.discardPile,
    required this.currentTurnUid,
    required this.isDeclaring,
  });

  final String roundId;
  final Map<String, List<String>> playerHands;
  final List<String> discardPile;
  final String currentTurnUid;
  final bool isDeclaring;

  RummyStateModel copyWith({
    Map<String, List<String>>? playerHands,
    List<String>? discardPile,
    String? currentTurnUid,
    bool? isDeclaring,
  }) {
    return RummyStateModel(
      roundId: roundId,
      playerHands: playerHands ?? this.playerHands,
      discardPile: discardPile ?? this.discardPile,
      currentTurnUid: currentTurnUid ?? this.currentTurnUid,
      isDeclaring: isDeclaring ?? this.isDeclaring,
    );
  }
}
