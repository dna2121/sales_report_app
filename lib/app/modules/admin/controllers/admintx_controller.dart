import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

import '../../auth/controllers/auth_controller.dart';

class AdminTxController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final AuthController authController = Get.find();

  void signOut() {
    authController.signOut();
  }

  Stream<QuerySnapshot<Object?>> streamTx() {
    return txRepo.txCollection.snapshots();
  }
}
