import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/repositories/game_repository.dart';
import '../../data/repositories/kyc_repository.dart';
import '../../data/repositories/table_repository.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/wallet_repository.dart';
import '../../domain/services/payment_gateway_service.dart';
import '../../domain/services/remote_config_service.dart';
import '../../domain/services/rng_service.dart';
import '../../domain/services/rummy_engine.dart';
import '../../domain/services/security_service.dart';
import '../../domain/services/mini_game_engine.dart';
import '../../presentation/controllers/admin_controller.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/controllers/kyc_controller.dart';
import '../../presentation/controllers/lobby_controller.dart';
import '../../presentation/controllers/rummy_controller.dart';
import '../../presentation/controllers/settings_controller.dart';
import '../../presentation/controllers/table_controller.dart';
import '../../presentation/controllers/wallet_controller.dart';

/// Registers application-wide dependencies using GetX Bindings.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(UserRepository.new);
    Get.lazyPut<WalletRepository>(WalletRepository.new);
    Get.lazyPut<TransactionRepository>(TransactionRepository.new);
    Get.lazyPut<KycRepository>(KycRepository.new);
    Get.lazyPut<TableRepository>(TableRepository.new);
    Get.lazyPut<GameRepository>(GameRepository.new);

    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance);
    Get.lazyPut<RngService>(RngService.new);
    Get.lazyPut<RummyEngine>(() => RummyEngine(rngService: Get.find()));
    Get.lazyPut<MiniGameEngine>(MiniGameEngine.new);
    Get.lazyPut<RemoteConfigService>(RemoteConfigService.new);
    Get.lazyPut<SecurityService>(SecurityService.new);
    Get.lazyPut<PaymentGatewayService>(MockPaymentGateway.new);

    Get.lazyPut<AuthController>(
        () => AuthController(Get.find<FirebaseAuth>(), Get.find()));
    Get.lazyPut<KycController>(() => KycController(Get.find(), Get.find()));
    Get.lazyPut<WalletController>(() => WalletController(
          walletRepository: Get.find(),
          transactionRepository: Get.find(),
          paymentGateway: Get.find(),
          remoteConfigService: Get.find(),
        ));
    Get.lazyPut<LobbyController>(() => LobbyController(
          tableRepository: Get.find(),
          walletRepository: Get.find(),
          remoteConfigService: Get.find(),
        ));
    Get.lazyPut<TableController>(() => TableController(
          tableRepository: Get.find(),
          gameRepository: Get.find(),
        ));
    Get.lazyPut<RummyController>(() => RummyController(
          rummyEngine: Get.find(),
          gameRepository: Get.find(),
          remoteConfigService: Get.find(),
        ));
    Get.lazyPut<AdminController>(() => AdminController(
          userRepository: Get.find(),
          kycRepository: Get.find(),
          walletRepository: Get.find(),
          tableRepository: Get.find(),
          transactionRepository: Get.find(),
        ));
    Get.lazyPut<SettingsController>(() => SettingsController(remoteConfigService: Get.find()));
  }
}
