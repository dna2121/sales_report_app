import 'package:get/get.dart';

import 'package:sales_report_app/app/modules/transaction/controllers/detail_tx_controller.dart';

import '../controllers/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTxController>(
      () => DetailTxController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
  }
}
