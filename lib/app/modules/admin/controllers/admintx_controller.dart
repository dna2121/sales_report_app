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

  String? selectedName;

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

  void addTrx() async {
    if (trxFormKey.currentState!.validate()) {
      String harga = hargaController.text;

      String? userID = await getUserIdFromName(selectedName.toString());

      if (userID != null) {
        CollectionReference trxCollection =
            FirebaseFirestore.instance.collection('Transaction');

        DocumentReference docref = await trxCollection.add({
          'harga': harga,
          'name': selectedName,
          'transactionID': FieldValue.serverTimestamp(),
          'userID': userID
        });

        //to get the transaction ID
        String transactionID = docref.id;
        await docref.update({
          'transactionID': transactionID,
        });

        Get.defaultDialog(
          title: 'Success',
          middleText: "Data added.",
          onConfirm: () {
            hargaController.clear();
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
