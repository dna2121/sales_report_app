import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/auth_controller.dart';

class SigninController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();

  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle().value;
  }

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
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill the filled';
    }
    return null;
  }

  void signin() {
    if (loginFormKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      authController.signIn(email, password);
    }
  }
}
