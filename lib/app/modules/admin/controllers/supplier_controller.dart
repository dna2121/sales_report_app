import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';

class SupplierController extends GetxController {
  final userRepo = UserRepository.instance;
  final emailC = TextEditingController();
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final addressC = TextEditingController();
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

  Stream<QuerySnapshot<Object?>> getUser() {
    return userRepo.userCollection.orderBy("name").snapshots();
  }

  void deleteUser(String keyid) {
    DocumentReference<Object?> documentReference =
        userRepo.userCollection.doc(keyid);

    try {
      Get.defaultDialog(
        title: "Hapus Data",
        middleText: "Data dihapus?",
        onConfirm: () async {
          Get.back();
          Get.defaultDialog(
            title: "Tindakan ini tidak dapat dibatalkan!",
            middleText: "Yakin menghapus data?",
            onConfirm: () async {
              await documentReference.delete();
              Get.back();
              Get.back();
            },
            textConfirm: "Ya",
            textCancel: "Kembali",
          );
        },
        textConfirm: "Ya",
        textCancel: "Tidak",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Sesuatu bermasalah",
        middleText: "Gagal menghapus data.",
      );
    }
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

      // var newUser = AuthController.instance.firebaseAuth.currentUser;

      // String? userID =
      //     await getUserIdFromDocId(documentId); //untuk dapat uid account

      // newUser!.updateDisplayName(newName);

      Get.defaultDialog(
        title: 'Berhasil',
        middleText: "Data diubah.",
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

  Future<String?> getUserIdFromDocId(String docId) async {
    // Get a reference to the Firestore collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    // Query the collection to find the document with the matching name
    QuerySnapshot<Object?> snapshot =
        await usersCollection.where('id', isEqualTo: docId).limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      // Retrieve the first document from the query snapshot
      QueryDocumentSnapshot<Object?> documentSnapshot = snapshot.docs[0];

      // Retrieve and return the document ID
      return documentSnapshot.id;
    }

    return null; // Return null if no matching document found
  }
}
