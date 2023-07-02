import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/user_profile.dart';
import 'package:sales_report_app/app/data/repositories/user_repositories.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final userRepo = UserRepository.instance;

  late Rx<User?> firebaseUser;
  late Rx<UserProfile?> userProfile;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    await Future.delayed(const Duration(seconds: 2));
    //nobody has logged in yet, == null
    if (user == null) {
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      Get.offAllNamed(Routes.TRX);
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

  void signUp(String email, String password, String name, String phoneNumber,
      String address) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      var newUser = firebaseAuth.currentUser; //untuk dapat uid account

      newUser!.updateDisplayName(name);

      userRepo.addUser(UserProfile(
          id: newUser.uid,
          email: email,
          name: name,
          role: ['user'],
          phoneNumber: phoneNumber,
          address: address));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Sign up success',
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
