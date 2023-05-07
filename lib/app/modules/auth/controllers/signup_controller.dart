import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  // final AuthController authController = Get.find();

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
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    return null;
  }

  void signUp() {
    if (signupFormKey.currentState!.validate()) {
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String phoneNumber = phoneNumberController.text;
      String address = addressController.text;

      // authController.signUp(email, password, name);
      AuthController.instance
          .signUp(email, password, name, phoneNumber, address);
    }
  }
}
