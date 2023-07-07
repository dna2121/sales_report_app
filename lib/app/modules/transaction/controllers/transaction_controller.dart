import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/data/repositories/user_repositories.dart';

import '../../../data/repositories/transactions_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class TransactionController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final userRepo = UserRepository.instance;
  final AuthController authController = Get.find();
  final dtTxFormKey = GlobalKey<FormState>();
  final priceC = TextEditingController();
  final nameC = TextEditingController();
  final dateC = TextEditingController();
  final weightC = TextEditingController();
  
  late String documentId;

  void signOut() {
    authController.signOut();
  }

  Stream<DocumentSnapshot<Object?>> getRole() {
    return userRepo.userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamTxById() {
    return txRepo.txCollection
        .where("userID",
            isEqualTo: AuthController.instance.firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getDetailTx() {
    return txRepo.txCollection
        .doc(documentId)
        .snapshots();
  }

  @override
  void onClose() {
    priceC.dispose();
    nameC.dispose();
    // carC.dispose();
    weightC.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    return null;
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
        Timestamp timestamp = data['date'] as Timestamp;

        priceC.text = price.toString();
        nameC.text = name;
        dateC.text = DateFormat('dd MMMM yyyy').format(timestamp.toDate());
        weightC.text = weight.toString();
      }
    } catch (error) {
      print('Failed to fetch document data: $error');
    }
  }
}
