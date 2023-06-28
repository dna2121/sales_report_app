import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';

class SupplierController extends GetxController {
  final userRepo = UserRepository.instance;

  Stream<QuerySnapshot<Object?>> getUser() {
    return userRepo.userCollection.orderBy("name").snapshots();
  }

  void deleteUser(String keyid) {
    DocumentReference<Object?> documentReference =
        userRepo.userCollection.doc(keyid);

    try {
      Get.defaultDialog(
        title: "Delete Data",
        middleText: "Do you want to delete the data?",
        onConfirm: () async {
          Get.back();
          Get.defaultDialog(
            title: "This action can't be undone",
            middleText: "Are you sure?",
            onConfirm: () async {
              await documentReference.delete();
              Get.back();
              Get.back();
            },
            textConfirm: "Yes",
            textCancel: "No",
          );
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
