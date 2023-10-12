import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/supplier_controller.dart';

class SupplierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupplierController>(
      () => SupplierController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
