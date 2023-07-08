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
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: StringButton(
                  pressed: () {
                    controller.resetPassword();
                  },
                  text: "Reset Password"),
            )
          ],
        ),
      ),
    );
  }
}
