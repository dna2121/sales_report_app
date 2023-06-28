import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

import '../../../data/models/transactions.dart';
import '../../auth/controllers/auth_controller.dart';

class AdminTxController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final AuthController authController = Get.find();
  final trxFormKey = GlobalKey<FormState>();
  final priceC = TextEditingController();
  final nameC = TextEditingController();
  // final carC = TextEditingController();
  final weightC = TextEditingController();

  late String documentId;
  String? selectedName;

  void onClose() {
    priceC.dispose();
    weightC.dispose();
    super.onClose();
  }

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
        int weight = data['weight'] as int;
        priceC.text = price.toString();
        nameC.text = name;
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
      await txRepo.txCollection
          .doc(documentId)
          .update({'name': newName, 'price': newPrice, 'weight': newWeight});

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
      int harga = int.parse(priceC.text);
      int berat = int.parse(weightC.text);
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
            priceC.clear();
            weightC.clear();
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
