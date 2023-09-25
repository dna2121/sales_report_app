import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../../../../utils/color.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: AppColor.body),
            child: Icon(
              Icons.lock_person_outlined,
              color: Colors.white,
              size: 50,
            ),
          ),
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
                backgroundColor: AppColor.putihBtn,
                pressed: () {
                  controller.resetPassword();
                },
                text: "Send"),
          )
        ],
      ),
    );
  }
}
