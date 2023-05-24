import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

class AdminTxView extends GetView<AdminTxController> {
  const AdminTxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminTX',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
