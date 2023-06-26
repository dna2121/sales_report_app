import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/update_tx_controller.dart';

class UpdateTxView extends GetView<UpdateTxController> {
  const UpdateTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateTxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UpdateTxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
