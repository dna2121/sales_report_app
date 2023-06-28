import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

import '../../auth/controllers/auth_controller.dart';

class AdminTxController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final AuthController authController = Get.find();
  final dtTxFormKey = GlobalKey<FormState>();
  final priceC = TextEditingController();
  final nameC = TextEditingController();
  // final carC = TextEditingController();
  final weightC = TextEditingController();

  late String documentId;

  void signOut() {
    authController.signOut();
  }

  Stream<QuerySnapshot<Object?>> streamTx() {
    return txRepo.txCollection.snapshots();
  }

  String? validator(String? value) {
    return null;
  }

  void deleteTx(String keyid) {
    DocumentReference<Object?> documentReference =
        txRepo.txCollection.doc(keyid);

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

  void fetchTxDoc() async {
    try {
      DocumentSnapshot snapshot =
          await txRepo.txCollection.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int price = data['price'] as int;
        String name = data['name'] as String;
        // String car = data['carNumber'] as String;
        int weight = data['weight'] as int;
        priceC.text = price.toString();
        nameC.text = name;
        // carC.text = car;
        weightC.text = weight.toString();
      }
    } catch (error) {
      print('Failed to fetch document data: $error');
    }
  }

  void updateTxDoc() async {
    String newName = nameC.text;
    int newPrice = int.parse(priceC.text);
    int newWeight = int.parse(weightC.text);

    try {
      await FirebaseFirestore.instance
          .collection('Transaction')
          .doc(documentId)
          .update(
        {'name': newName, 'price': newPrice, 'weight': newWeight},
        // SetOptions(merge: true)
      );

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data updated.",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          weightC.clear();
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
