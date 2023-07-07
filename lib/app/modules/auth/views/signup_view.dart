import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signup_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.signupFormKey,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                RegisterField(
                  hintText: "Name",
                  textEditingController: controller.nameController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 17),
                RegisterField(
                  hintText: "Email",
                  textEditingController: controller.emailController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 17),
                RegisterField(
                  hintText: "Phone Number",
                  textEditingController: controller.phoneNumberController,
                  validator: controller.validator,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 17),
                RegisterField(
                  hintText: "Address",
                  textEditingController: controller.addressController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 17),
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
                SizedBox(
                  height: 37,
                ),
                StringButton(
                    pressed: () => controller.signUp(), text: "Sign up")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
