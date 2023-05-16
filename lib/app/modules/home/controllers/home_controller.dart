import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
  final AuthController authController = Get.find();
  final carsController = TextEditingController();

  void signOut() {
    authController.signOut();
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
    carsController.dispose();
    super.onClose();
  }
}
