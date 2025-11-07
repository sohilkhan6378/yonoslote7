import 'package:get/get.dart';

import '../../data/models/game_round_model.dart';
import '../../data/models/rummy_state_model.dart';
import '../../data/repositories/game_repository.dart';
import '../../domain/services/remote_config_service.dart';
import '../../domain/services/rummy_engine.dart';

class RummyController extends GetxController {
  RummyController({
    required RummyEngine rummyEngine,
    required GameRepository gameRepository,
    required RemoteConfigService remoteConfigService,
  })  : _engine = rummyEngine,
        _gameRepository = gameRepository,
        _remoteConfigService = remoteConfigService;

  final RummyEngine _engine;
  final GameRepository _gameRepository;
  final RemoteConfigService _remoteConfigService;

  final Rxn<RummyStateModel> state = Rxn<RummyStateModel>();
  final RxBool declaring = false.obs;

  Future<String> startLocalRound(List<String> playerIds) async {
    if (!_remoteConfigService.enableMiniGame) {
      // Remote config can disable demo rounds if required for compliance.
    }
    final seed = _engine.generateSeed();
    final hands = _engine.deal(playerIds.length, seed: seed);
    final deals = <String, List<String>>{};
    for (var i = 0; i < playerIds.length; i++) {
      deals[playerIds[i]] = hands[i];
    }
    final roundId = 'local-$seed';
    final round = GameRoundModel(
      id: roundId,
      tableId: 'local-table',
      deckSeed: seed,
      deals: deals,
      turnIndex: 0,
      discardPile: const <String>[],
      winnerUid: null,
      settled: false,
      createdAt: DateTime.now(),
    );
    await _gameRepository.saveRound(round);
    state.value = RummyStateModel(
      roundId: roundId,
      playerHands: deals,
      discardPile: const <String>[],
      currentTurnUid: playerIds.first,
      isDeclaring: false,
    );
    return roundId;
  }

  Future<void> onRoundUpdate(GameRoundModel round) async {
    state.value = RummyStateModel(
      roundId: round.id,
      playerHands: round.deals,
      discardPile: round.discardPile,
      currentTurnUid: round.deals.keys.elementAt(round.turnIndex % round.deals.length),
      isDeclaring: round.settled,
    );
  }
}
