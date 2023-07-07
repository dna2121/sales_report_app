import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/car.dart';
import 'package:sales_report_app/utils/color.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class CarsController extends GetxController {
  final carsFormKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final userRepo = UserRepository.instance;
  final carsController = TextEditingController();

  late String documentId;

  void signOut() {
    authController.signOut();
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
      ));

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data added.",
        onConfirm: () {
          carsController.clear();
          Get.back(); //close dialog
          Get.back(); //closs bottom sheet
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
            Get.back(); //close dialog
            Get.back(); //close the bottom sheet
          },
          textConfirm: "Yes",
          textCancel: "No",
          backgroundColor: AppColor.background);
    } catch (e) {
      Get.defaultDialog(
        title: "Something's wrong.",
        middleText: "Delete data failed.",
      );
    }
  }

  void fetchCarDoc() async {
    try {
      DocumentSnapshot snapshot =
          await userRepo.carCollection.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String carNum = data['carNumber'] as String;
        carsController.text = carNum;
      }
    } catch (error) {
      print('Failed to fetch document data: $error');
    }
  }

  void updateCarDoc() async {
    String newCarNum = carsController.text;

    try {
      await userRepo.carCollection
          .doc(documentId)
          .update({'carNumber': newCarNum});

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data updated.",
        onConfirm: () {
          carsController.clear();
          Get.back(); //close dialog
          Get.back(); //close page
          Get.back(); //close bottom sheet
        },
        textConfirm: 'Okay',
      );

      print('Document updated successfully');
    } catch (error) {
      print('Failed to update document: $error');
    }
  }

  final searchC = TextEditingController();
  final carSnapshot = Rxn<QuerySnapshot>();

  @override
  void onInit() {
    super.onInit();
    fetchCarList();
  }

  void fetchCarList() {
    carSnapshot.bindStream(StreamCar());
  }

  void onSearchTextChanged(String value) {
    if (value.isEmpty) {
      carSnapshot.bindStream(StreamCar());
    } else {
      carSnapshot.bindStream(searchDocuments(value));
    }
  }

  Stream<QuerySnapshot> searchDocuments(String keyword) {
    final currentUserID = AuthController.instance.firebaseAuth.currentUser!.uid;

    return userRepo.carCollection
        .where("userID", isEqualTo: currentUserID)
        .where("carNumber", isGreaterThanOrEqualTo: keyword)
        .where("carNumber", isLessThanOrEqualTo: "${keyword}\uf8ff")
        .snapshots();
  }
}
