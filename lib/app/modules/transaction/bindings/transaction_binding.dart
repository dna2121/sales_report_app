import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/home/controllers/home_controller.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/admin_transaction_controller.dart';

import '../controllers/user_transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserTransactionController>(
      () => UserTransactionController(),
    );
    Get.lazyPut<AdminTransactionController>(
      () => AdminTransactionController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
