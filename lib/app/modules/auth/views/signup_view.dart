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
      body: Form(
        // key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 37,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
