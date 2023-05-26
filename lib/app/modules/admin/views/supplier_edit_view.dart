import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/supplier_edit_controller.dart';

class SupplierEditView extends GetView<SupplierEditController> {
  const SupplierEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupplierEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SupplierEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
