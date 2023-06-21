import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/car.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class CarsController extends GetxController {
  final carsFormKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final userRepo = UserRepository.instance;
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

  Stream<QuerySnapshot<Object?>> StreamCar() {
    return userRepo.carCollection
        .where("userID",
            isEqualTo: AuthController.instance.firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  void addCar() {
    if (carsFormKey.currentState!.validate()) {
      String carNumber = carsController.text;

      userRepo.addTruck(Car(
          carID: userRepo.carCollection.doc().id,
          userID: '${AuthController.instance.firebaseAuth.currentUser!.uid}',
          carNumber: carNumber,
          timestamp: DateTime.now()));

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

  void deleteCar(String keyid) {
    DocumentReference<Object?> documentReference =
        userRepo.carCollection.doc(keyid);

    try {
      Get.defaultDialog(
        title: "Delete Data",
        middleText: "Do you want to delete the data?",
        onConfirm: () async {
          await documentReference.delete();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "No",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Something's wrong.",
        middleText: "Delete data failed.",
      );
    }
  }
}