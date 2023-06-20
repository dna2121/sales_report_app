import 'package:get/get.dart';

import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';
import 'package:sales_report_app/app/modules/admin/controllers/new_tx_controller.dart';
import 'package:sales_report_app/app/modules/admin/controllers/supplier_controller.dart';

import '../controllers/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewTxController>(
      () => NewTxController(),
    );
    Get.lazyPut<AdminController>(
      () => AdminController(),
    );
    Get.lazyPut<AdminTxController>(
      () => AdminTxController(),
    );
    Get.lazyPut<SupplierController>(
      () => SupplierController(),
    );
  }
}
