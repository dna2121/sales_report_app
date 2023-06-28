import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/transaction_controller.dart';

class DetailTxView extends GetView<TransactionController> {
  const DetailTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaction'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: controller.nameC,
              validator: controller.validator,
              readOnly: true,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 17),
            Text(
              'Price',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: controller.priceC,
              validator: controller.validator,
              readOnly: true,
              decoration: InputDecoration(
                  prefixText: "Rp. ", border: OutlineInputBorder()),
            ),
            SizedBox(height: 17),
            // Text(
            //   'Car Number',
            //   style: TextStyle(fontSize: 18),
            // ),
            Text(
              'Weight',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: controller.weightC,
              validator: controller.validator,
              readOnly: true,
              decoration: InputDecoration(
                  suffixText: "kg ", border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}
