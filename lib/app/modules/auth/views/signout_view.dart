import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/signout_controller.dart';

class SignoutView extends GetView<SignoutController> {
  const SignoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignoutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SignoutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}