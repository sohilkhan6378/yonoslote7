import 'package:get/get.dart';

import '../../data/models/kyc_model.dart';
import '../../data/repositories/kyc_repository.dart';
import '../../data/repositories/user_repository.dart';

class KycController extends GetxController {
  KycController(this._kycRepository, this._userRepository);

  final KycRepository _kycRepository;
  final UserRepository _userRepository;

  final Rxn<KycModel> currentKyc = Rxn<KycModel>();
  final RxBool uploading = false.obs;

  Future<void> loadKyc(String uid) async {
    currentKyc.value = await _kycRepository.fetchKyc(uid);
  }

  Future<void> submitDocuments({
    required String uid,
    required String panMasked,
    required String frontUrl,
    required String backUrl,
    required String selfieUrl,
  }) async {
    uploading.value = true;
    final model = KycModel(
      uid: uid,
      panNumberMasked: panMasked,
      idFrontUrl: frontUrl,
      idBackUrl: backUrl,
      selfieUrl: selfieUrl,
      status: 'pending',
      reason: null,
      reviewedBy: null,
      updatedAt: DateTime.now(),
    );
    await _kycRepository.submitKyc(model);
    final user = await _userRepository.fetchUser(uid);
    if (user != null) {
      await _userRepository.upsertUser(user.copyWith(kycStatus: 'pending'));
    }
    currentKyc.value = model;
    uploading.value = false;
  }
}
