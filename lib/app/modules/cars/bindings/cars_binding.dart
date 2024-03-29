import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/cars_controller.dart';

class CarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarsController>(
      () => CarsController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
