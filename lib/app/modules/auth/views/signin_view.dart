import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/views/forgot_password_view.dart';
import 'package:sales_report_app/utils/color.dart';
import 'package:sales_report_app/utils/widget.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              RegisterField(
                hintText: "Email",
                validator: controller.validator,
                textEditingController: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 27),
              Obx(() => RegisterField(
                    hintText: "Password",
                    textEditingController: controller.passwordController,
                    validator: controller.validator,
                    obscureText: controller.isPasswordHidden.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                      icon: Icon(controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                    ),
                  )),
              // SizedBox(height: 17),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.to(ForgotPasswordView());
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: AppColor.green),
                    )),
              ),
              SizedBox(
                height: 47,
              ),
              StringButton(pressed: () => controller.signin(), text: "Login")
            ],
          ),
        ),
      ),
    );
  }
}
