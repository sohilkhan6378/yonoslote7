import 'package:get/get.dart';

import '../../data/models/table_model.dart';
import '../../data/repositories/table_repository.dart';
import '../../data/repositories/wallet_repository.dart';
import '../../domain/services/remote_config_service.dart';

class LobbyController extends GetxController {
  LobbyController({
    required TableRepository tableRepository,
    required WalletRepository walletRepository,
    required RemoteConfigService remoteConfigService,
  })  : _tableRepository = tableRepository,
        _walletRepository = walletRepository,
        _remoteConfigService = remoteConfigService;

  final TableRepository _tableRepository;
  final WalletRepository _walletRepository;
  final RemoteConfigService _remoteConfigService;

  final RxList<TableModel> tables = <TableModel>[].obs;
  final RxDouble balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _tableRepository.watchActiveTables().listen(tables.assignAll);
  }

  Future<void> refreshBalance(String uid) async {
    await _remoteConfigService.ensureFetched();
    balance.value = (await _walletRepository.fetchWallet(uid)).balance;
  }
}
