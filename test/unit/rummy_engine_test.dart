import 'package:flutter_test/flutter_test.dart';

import 'package:rummy_pro/domain/services/rng_service.dart';
import 'package:rummy_pro/domain/services/rummy_engine.dart';

void main() {
  group('RummyEngine', () {
    final engine = RummyEngine(rngService: RngService());

    test('buildDeck includes jokers', () {
      final deck = engine.buildDeck();
      expect(deck.contains('JOKER'), isTrue);
    });

    test('deal hands out cards to players', () {
      final hands = engine.deal(2, seed: 42);
      expect(hands.length, 2);
      expect(hands.first.length, 13);
    });

    test('validateHand requires pure sequence', () {
      final valid = engine.validateHand([
        ['2H', '3H', '4H'],
        ['5D', '6D', '7D'],
      ]);
      expect(valid, isTrue);
    });
  });
}
