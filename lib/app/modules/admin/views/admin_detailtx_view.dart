import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admin_detailtx_controller.dart';

class AdminDetailtxView extends GetView<AdminDetailtxController> {
  const AdminDetailtxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminDetailtxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminDetailtxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
