import 'package:get/get.dart';

import '../modules/auth/controllers/auth_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );
  }

}
