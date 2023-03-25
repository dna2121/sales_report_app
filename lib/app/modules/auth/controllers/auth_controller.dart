import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final firebaseAuth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
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
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
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
}
