import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onClose() {
    // emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      Get.showSnackbar(GetSnackBar(
        message: 'Password reset email sent',
        duration: Duration(seconds: 3),
      ));
      emailController.clear();
      Get.offAllNamed(Routes.SIGNIN);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: Duration(seconds: 3),
      ));
    }
  }
}
