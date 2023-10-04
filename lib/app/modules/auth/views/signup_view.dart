import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signup_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../../../../utils/color.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.signupFormKey,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 17, right: 17, top: 7, bottom: 30),
            child: Column(
              children: [
                Image(height: 200, image: AssetImage('asset/image/signup.png')),
                SizedBox(height: 30),
                RegisterField(
                  hintText: "Nama",
                  textEditingController: controller.nameController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(height: 27),
                RegisterField(
                  hintText: "Email",
                  textEditingController: controller.emailController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 27),
                RegisterField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13)
                  ],
                  hintText: "Nomor Handphone",
                  textEditingController: controller.phoneNumberController,
                  validator: controller.validator,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 27),
                RegisterField(
                  hintText: "Alamat",
                  textEditingController: controller.addressController,
                  validator: controller.validator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 27),
                Obx(() => RegisterField(
                      hintText: "Password",
                      textEditingController: controller.passwordController,
                      validator: controller.passwordValidator,
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
                    backgroundColor: AppColor.putihBtn,
                    pressed: () => controller.signUp(),
                    text: "Sign up")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
