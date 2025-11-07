import 'package:get/get.dart';

import '../../data/models/game_round_model.dart';
import '../../data/models/table_model.dart';
import '../../data/repositories/game_repository.dart';
import '../../data/repositories/table_repository.dart';

class TableController extends GetxController {
  TableController({
    required TableRepository tableRepository,
    required GameRepository gameRepository,
  })  : _tableRepository = tableRepository,
        _gameRepository = gameRepository;

  final TableRepository _tableRepository;
  final GameRepository _gameRepository;

  final Rxn<TableModel> table = Rxn<TableModel>();
  final Rxn<GameRoundModel> currentRound = Rxn<GameRoundModel>();

  Future<void> loadTable(String tableId) async {
    table.value = await _tableRepository.fetchTable(tableId);
  }

  void subscribeToRound(String roundId) {
    _gameRepository.watchRound(roundId).listen(currentRound.call);
  }
}
