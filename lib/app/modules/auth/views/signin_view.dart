import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/utils/color.dart';
import 'package:sales_report_app/utils/widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.emailController.clear();
    controller.passwordController.clear();

    return Scaffold(
      backgroundColor: AppColor.boxShadow,
      body: SingleChildScrollView(
        child: Form(
          key: controller.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                SizedBox(height: 150),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.body),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(height: 35),
                RegisterField(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  validator: controller.validator,
                  textEditingController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 27),
                Obx(() => RegisterField(
                      prefixIcon: Icon(Icons.password),
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
                        Get.toNamed(Routes.FORGOTPASSWORD);
                      },
                      child: Text(
                        "Forgot password?",
                      )),
                ),
                SizedBox(
                  height: 47,
                ),
                StringButton(
                    backgroundColor: AppColor.putihBtn,
                    pressed: () => controller.signin(),
                    text: "Login")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
