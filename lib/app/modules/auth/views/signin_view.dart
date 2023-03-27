import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';
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
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: controller.validator,
                controller: controller.emailController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: controller.validator,
                controller: controller.passwordController,
              ),
              SizedBox(
                height: 37,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.signin();
                  },
                  child: Text("Login"),
                ),
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text("Sign up here."),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
