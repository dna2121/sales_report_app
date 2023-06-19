import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_report_app/app/data/models/transactions.dart';

class TransactionRepository {
  TransactionRepository._();

  static TransactionRepository get instance {
    return TransactionRepository._();
  }

  CollectionReference txCollection =
      FirebaseFirestore.instance.collection('Transaction');

  addTx(Transactions transactions) async {
    await txCollection
        .doc(transactions.transactionID)
        .set(transactions.toMap());
  }
}
