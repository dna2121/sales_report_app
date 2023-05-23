import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class CarsController extends GetxController {
  final carsFormKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final userRepo = UserRepository.instance;
  final carsController = TextEditingController();

  String name = '';

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
    super.onClose();
  }

  String? validator(String? value) {
    return null;
  }

  String? get textEmpty {
    Get.defaultDialog(
      title: 'Failed',
      middleText: "Text cannot be empty",
      onConfirm: () {
        Get.back(); //close dialog
      },
      textConfirm: 'Okay',
    );
    return null;
  }

  void addNewCar() {
    if (carsFormKey.currentState!.validate()) {
      String carNumber = carsController.text;

      userRepo.addCars(carNumber);

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data added.",
        onConfirm: () {
          carsController.clear();
          Get.back(); //close dialog
        },
        textConfirm: 'Okay',
      );
    }
  }

  Stream<QuerySnapshot<Object?>> getCars() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    return userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .collection("Cars")
        .orderBy("timestamps", descending: true)
        .snapshots();
  }
}
