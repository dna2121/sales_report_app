import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/repositories/user_repositories.dart';

import '../../../data/repositories/transactions_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class TransactionController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final userRepo = UserRepository.instance;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Stream<DocumentSnapshot<Object?>> getRole() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');

    return userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamTxById() {
    return txRepo.txCollection
        .where("userID",
            isEqualTo: AuthController.instance.firebaseAuth.currentUser!.uid)
        .snapshots();
  }
}
