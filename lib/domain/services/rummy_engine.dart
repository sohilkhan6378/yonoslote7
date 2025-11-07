import 'dart:math';

import 'rng_service.dart';

/// Lightweight implementation of Rummy rules to validate melds client-side.
class RummyEngine {
  RummyEngine({required RngService rngService}) : _rngService = rngService;

  final RngService _rngService;

  static const _suits = ['H', 'D', 'C', 'S'];
  static const _ranks = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];

  List<String> buildDeck({int jokersPerDeck = 2}) {
    final deck = <String>[];
    for (final suit in _suits) {
      for (final rank in _ranks) {
        deck..add('$rank$suit')..add('$rank$suit');
      }
    }
    for (var i = 0; i < jokersPerDeck; i++) {
      deck.add('JOKER');
    }
    return deck;
  }

  List<List<String>> deal(int players, {int cardsPerPlayer = 13, int? seed}) {
    final deck = buildDeck();
    final random = seed != null ? _rngService.seeded(seed) : Random();
    deck.shuffle(random);
    final hands = List<List<String>>.generate(players, (_) => []);
    for (var i = 0; i < cardsPerPlayer; i++) {
      for (var player = 0; player < players; player++) {
        hands[player].add(deck.removeAt(0));
      }
    }
    return hands;
  }

  /// Validates a player's hand ensuring at least two sequences with one pure sequence.
  bool validateHand(List<List<String>> melds) {
    if (melds.length < 2) {
      return false;
    }
    final sequences = melds.where(_isSequence).toList();
    final pureSequences = sequences.where((sequence) => !_containsJoker(sequence));
    return sequences.length >= 2 && pureSequences.isNotEmpty;
  }

  bool _isSequence(List<String> cards) {
    if (cards.length < 3) {
      return false;
    }
    final suit = cards.first.substring(cards.first.length - 1);
    final rankIndices = cards.map((card) => _rankIndex(card)).toList()..sort();
    for (var i = 1; i < rankIndices.length; i++) {
      if (rankIndices[i] != rankIndices[i - 1] + 1) {
        return false;
      }
    }
    final suitsMatch = cards.every((card) => card.endsWith(suit));
    return suitsMatch;
  }

  bool _containsJoker(List<String> cards) => cards.any((card) => card == 'JOKER');

  int _rankIndex(String card) {
    final rank = card.replaceAll(RegExp(r'[HDCS]'), '');
    return _ranks.indexOf(rank);
  }

  int generateSeed() => _rngService.nextSeed();
}
