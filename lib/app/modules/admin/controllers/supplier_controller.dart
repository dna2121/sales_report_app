import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/user_profile.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class SupplierController extends GetxController {
  final supplFormKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final userRepo = UserRepository.instance;
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  // String name = '';

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    return null;
  }

  String? get textEmpty {
    Get.defaultDialog(
      title: 'Failed',
      middleText: "Something cannot be empty",
      onConfirm: () {
        Get.back(); //close dialog
      },
      textConfirm: 'Okay',
    );
    return null;
  }

  void addNewUser() async {
    if (supplFormKey.currentState!.validate()) {
      String name = nameController.text;
      String phoneNumber = phoneNumberController.text;
      String address = addressController.text;

      userRepo.addUser(
        UserProfile(
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          id: userRepo.userCollection.doc().id,
          role: ['user'],
        ),
      );

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data added.",
        onConfirm: () {
          nameController.clear();
          phoneNumberController.clear();
          addressController.clear();

          Get.back(); //close dialog
        },
        textConfirm: 'Okay',
      );
    }
  }

  Stream<QuerySnapshot<Object?>> getUser() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    return userCollection.orderBy("name").snapshots();
  }

  void deleteProduct(String keyid) async {
    DocumentReference documentReference = userRepo.userCollection.doc(keyid);

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
