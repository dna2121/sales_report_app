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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: controller.loginFormKey,
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Image(
                      height: 200,
                      image: AssetImage('asset/image/login.png'),
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
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.FORGOTPASSWORD);
                          },
                          child: Text("Forgot password?")),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    StringButton(
                        color: Colors.white,
                        backgroundColor: AppColor.fabBtn,
                        pressed: () => controller.signin(),
                        text: "Login")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
