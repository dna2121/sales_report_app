import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../controllers/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<AdminTxController>(
      () => AdminTxController(),
    );
  }
}
