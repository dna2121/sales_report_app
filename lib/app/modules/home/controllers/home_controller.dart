import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
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
    carsController.dispose();
    super.onClose();
  }

  void addNewCar() {
    String carNumber = carsController.text;

    userRepo.addCars(carNumber);

    Get.defaultDialog(
      title: 'Success',
      onConfirm: () {
        carsController.clear();
        Get.back(); //close dialog
      },
      textConfirm: 'Okay',
    );
  }

  Stream<QuerySnapshot<Object?>> getCars() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    return userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .collection("Cars")
        .snapshots();
  }
}
