import 'package:get/get.dart';

import '../../data/models/kyc_model.dart';
import '../../data/models/table_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/kyc_repository.dart';
import '../../data/repositories/table_repository.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/wallet_repository.dart';

class AdminController extends GetxController {
  AdminController({
    required UserRepository userRepository,
    required KycRepository kycRepository,
    required WalletRepository walletRepository,
    required TableRepository tableRepository,
    required TransactionRepository transactionRepository,
  })  : _userRepository = userRepository,
        _kycRepository = kycRepository,
        _walletRepository = walletRepository,
        _tableRepository = tableRepository,
        _transactionRepository = transactionRepository;

  final UserRepository _userRepository;
  final KycRepository _kycRepository;
  final WalletRepository _walletRepository;
  final TableRepository _tableRepository;
  final TransactionRepository _transactionRepository;

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<KycModel> pendingKycs = <KycModel>[].obs;
  final RxList<TableModel> adminTables = <TableModel>[].obs;
  final RxList<TransactionModel> latestTransactions = <TransactionModel>[].obs;
  final RxDouble totalWalletBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    users.assignAll(await _userRepository.fetchAllUsers());
    _kycRepository.watchPending().listen(pendingKycs.assignAll);
    _tableRepository.watchActiveTables().listen(adminTables.assignAll);
    _transactionRepository
        .watchTransactions('demo-user')
        .listen(latestTransactions.assignAll);
    double runningBalance = 0;
    for (final user in users) {
      final wallet = await _walletRepository.fetchWallet(user.uid);
      runningBalance += wallet.balance;
    }
    totalWalletBalance.value = runningBalance;
  }
}
