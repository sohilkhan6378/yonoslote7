import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class AuthController extends GetxController {
  AuthController(this._auth, this._userRepository);

  final FirebaseAuth _auth;
  final UserRepository _userRepository;

  final Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        user.value = null;
        return;
      }
      final profile = await _userRepository.fetchUser(firebaseUser.uid);
      user.value = profile ??
          UserModel(
            uid: firebaseUser.uid,
            displayName: firebaseUser.displayName,
            email: firebaseUser.email,
            phone: firebaseUser.phoneNumber,
            photoUrl: firebaseUser.photoURL,
            kycStatus: 'pending',
            createdAt: DateTime.now(),
            banned: false,
            roles: const ['player'],
            region: null,
          );
    });
  }

  Future<void> signOut() => _auth.signOut();
}
