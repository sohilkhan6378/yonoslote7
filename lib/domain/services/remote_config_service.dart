import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  RemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> ensureFetched() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  double get rakePercentage => _remoteConfig.getDouble('rake_percentage');
  bool get enableMockPayments => _remoteConfig.getBool('enable_mock_payments');
  String get allowedRegions => _remoteConfig.getString('allowed_regions');
  bool get enableMiniGame => _remoteConfig.getBool('enable_mini_game');
}
