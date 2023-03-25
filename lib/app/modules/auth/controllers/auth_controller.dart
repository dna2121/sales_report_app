import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final firebaseAuth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    await Future.delayed(const Duration(seconds: 3));
    if (user == null) {
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Sign in success',
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void signOut() {
    firebaseAuth.signOut();
  }
}
