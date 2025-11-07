import 'package:get/get.dart';

import '../../data/models/transaction_model.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../data/repositories/wallet_repository.dart';
import '../../domain/services/payment_gateway_service.dart';
import '../../domain/services/remote_config_service.dart';

class WalletController extends GetxController {
  WalletController({
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
    required PaymentGatewayService paymentGateway,
    required RemoteConfigService remoteConfigService,
  })  : _walletRepository = walletRepository,
        _transactionRepository = transactionRepository,
        _paymentGatewayService = paymentGateway,
        _remoteConfigService = remoteConfigService;

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;
  final PaymentGatewayService _paymentGatewayService;
  final RemoteConfigService _remoteConfigService;

  final Rx<WalletModel?> wallet = Rx<WalletModel?>(null);
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final RxBool loading = false.obs;

  Future<void> loadWallet(String uid) async {
    await _remoteConfigService.ensureFetched();
    wallet.value = await _walletRepository.fetchWallet(uid);
    _transactionRepository.watchTransactions(uid).listen(transactions.assignAll);
  }

  Future<void> deposit(String uid, double amount) async {
    loading.value = true;
    if (!_remoteConfigService.enableMockPayments) {
      loading.value = false;
      return;
    }
    final orderId = await _paymentGatewayService.createDepositOrder(amount);
    final captured = await _paymentGatewayService.verifyAndCapture(
      orderId: orderId,
      signature: 'mock-signature',
    );
    if (captured) {
      await _walletRepository.updateBalance(uid: uid, delta: amount);
      wallet.value = await _walletRepository.fetchWallet(uid);
    }
    loading.value = false;
  }
}
