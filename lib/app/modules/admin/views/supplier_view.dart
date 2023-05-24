import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Suppliers',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
