import 'package:get/get.dart';

import '../../admin/controllers/supplier_controller.dart';
import '../controllers/cars_controller.dart';

class CarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarsController>(
      () => CarsController(),
    );
    Get.lazyPut<SupplierController>(
      () => SupplierController(),
    );
  }
}
