import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  void signin() {
    if (loginFormKey.currentState!.validate()) {}
  }
}
