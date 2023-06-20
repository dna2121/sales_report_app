import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

class AdminTxController extends GetxController {
  final txRepo = TransactionRepository.instance;

  Stream<QuerySnapshot<Object?>> streamTx() {
    return txRepo.txCollection.snapshots();
  }
}
