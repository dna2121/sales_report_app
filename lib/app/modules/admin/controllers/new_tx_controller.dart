import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/transactions.dart';
import '../../../data/repositories/transactions_repositories.dart';
import '../../../data/repositories/user_repositories.dart';

class NewTxController extends GetxController {
  final popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final trxFormKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final weightController = TextEditingController();
  final dateController = TextEditingController();
  final userRepo = UserRepository.instance;
  final txRepo = TransactionRepository.instance;

  String? selectedName;

  String? validator(String? value) {
    return null;
  }

  void onClose() {
    priceController.dispose();
    weightController.dispose();
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

  void addNewTx() async {
    if (trxFormKey.currentState!.validate()) {
      int harga = int.parse(priceController.text);
      int berat = int.parse(weightController.text);
      // DateTime tanggal = tanggalController.text as DateTime;

      String? userID = await getUserIdFromName(selectedName.toString());

      if (userID != null) {
        await txRepo.addTx(
          Transactions(
            userID: userID,
            transactionID: txRepo.txCollection.doc().id,
            name: selectedName.toString(),
            price: harga,
            weight: berat,
          ),
        );
        Get.defaultDialog(
          title: 'Success',
          middleText: "Data added.",
          onConfirm: () {
            priceController.clear();
            weightController.clear();
            Get.back(); //close dialog
          },
          textConfirm: 'Okay',
        );
      }
    }
  }

  Future<String?> getUserIdFromName(String selectedName) async {
    // Get a reference to the Firestore collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    // Query the collection to find the document with the matching name
    QuerySnapshot<Object?> snapshot = await usersCollection
        .where('name', isEqualTo: selectedName)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Retrieve the first document from the query snapshot
      QueryDocumentSnapshot<Object?> documentSnapshot = snapshot.docs[0];

      // Retrieve and return the document ID
      return documentSnapshot.id;
    }

    return null; // Return null if no matching document found
  }
}
