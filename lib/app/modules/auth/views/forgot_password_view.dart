import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(height: 200, image: AssetImage('asset/image/pw.png')),
              SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email == null ? 'Enter a valid email' : null,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: StringButton(
                    color: Colors.white,
                    pressed: () {
                      controller.resetPassword();
                    },
                    text: "Send"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
