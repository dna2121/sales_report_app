import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Hi ${AuthController.instance.firebaseAuth.currentUser!.displayName.toString()}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
