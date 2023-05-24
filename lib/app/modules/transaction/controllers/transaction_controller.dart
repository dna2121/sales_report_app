import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class TransactionController extends GetxController {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Stream<QuerySnapshot<Object?>> getTx() {
    CollectionReference txCollection =
        FirebaseFirestore.instance.collection('Transaction');

    return txCollection.snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getRole() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    return userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }
}
