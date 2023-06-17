import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';

class AdminTxController extends GetxController {
  final popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final trxFormKey = GlobalKey<FormState>();
  final hargaController = TextEditingController();
  final userRepo = UserRepository.instance;

  String? selectedValue;

  String? validator(String? value) {
    return null;
  }

  void onClose() {
    hargaController.dispose();
    super.onClose();
  }

  Stream<List<String>> streamName() {
    Query<Map<String, dynamic>> itemsRef = FirebaseFirestore.instance
        .collection('Users')
        .orderBy("name", descending: false);
    return itemsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  void addTrc() async {
    if (trxFormKey.currentState!.validate()) {
      String harga = hargaController.text;

      CollectionReference trxCollection =
          FirebaseFirestore.instance.collection('Transaction');


      await trxCollection.add({'harga': harga, 'name': selectedValue});

      Get.defaultDialog(
        title: 'Success',
        middleText: "Data added.",
        onConfirm: () {
          hargaController.clear();
          selectedValue = null;
          Get.back(); //close dialog
        },
        textConfirm: 'Okay',
      );
    }
  }
}
