import 'package:get/get.dart';

import '../../domain/services/remote_config_service.dart';

class SettingsController extends GetxController {
  SettingsController({required RemoteConfigService remoteConfigService})
      : _remoteConfigService = remoteConfigService;

  final RemoteConfigService _remoteConfigService;

  final RxDouble rakePercentage = 0.0.obs;

  @override
  Future<void> onReady() async {
    await _remoteConfigService.ensureFetched();
    rakePercentage.value = _remoteConfigService.rakePercentage;
    super.onReady();
  }
}
