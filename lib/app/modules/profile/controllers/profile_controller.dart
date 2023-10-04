import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final userRepo = UserRepository.instance;
  final userFormKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final addressC = TextEditingController();
  final AuthController authController = Get.find();

  late String documentId;

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    phoneC.dispose();
    addressC.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    return null;
  }

  void signOut() {
    authController.signOut();
  }

  Stream<DocumentSnapshot<Object?>> getData() {
    return userRepo.userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }

  void fetchUsersDoc() async {
    try {
      DocumentSnapshot snapshot =
          await userRepo.userCollection.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String email = data['email'] as String;
        String name = data['name'] as String;
        String phone = data['phoneNumber'] as String;
        String address = data['address'] as String;
        emailC.text = email;
        nameC.text = name;
        phoneC.text = phone;
        addressC.text = address;
      }
    } catch (error) {
      print('Failed to fetch document data: $error');
    }
  }

  void updateUserDoc() async {
    String newName = nameC.text;
    String newPhone = phoneC.text;
    String newAddress = addressC.text;

    try {
      await userRepo.userCollection.doc(documentId).update(
          {'name': newName, 'address': newAddress, 'phoneNumber': newPhone});

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data updated.",
        onConfirm: () {
          emailC.clear();
          nameC.clear();
          addressC.clear();
          phoneC.clear();
          Get.back(); //close dialog
          Get.back(); //close page
        },
        textConfirm: 'Okay',
      );

      print('Document updated successfully');
    } catch (error) {
      print('Failed to update document: $error');
    }
  }
}
