import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signup_controller.dart';

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
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller: controller.nameController,
                  validator: controller.validator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  controller: controller.emailController,
                  validator: controller.validator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  controller: controller.phoneNumberController,
                  validator: controller.validator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Address"),
                  controller: controller.addressController,
                  validator: controller.validator,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: controller.passwordController,
                  validator: controller.validator,
                ),
                SizedBox(
                  height: 37,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signUp();
                    },
                    child: Text("Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
