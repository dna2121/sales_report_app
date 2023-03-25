import 'package:get/get.dart';

import 'package:sales_report_app/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signin_controller.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signout_controller.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signup_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
    Get.lazyPut<SignoutController>(
      () => SignoutController(),
    );
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
    Get.lazyPut<SigninController>(
      () => SigninController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
