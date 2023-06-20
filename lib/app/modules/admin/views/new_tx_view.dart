import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/new_tx_controller.dart';

class NewTxView extends GetView<NewTxController> {
  const NewTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewTxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewTxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
