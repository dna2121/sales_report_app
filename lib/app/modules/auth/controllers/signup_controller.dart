import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  String? validator(String? value) {
    return null;
  }

  void signUp() {
    if (signupFormKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      authController.signUp(email, password);
    }
  }
}
