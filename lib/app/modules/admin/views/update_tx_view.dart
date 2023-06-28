import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

class UpdateTxView extends GetView<AdminTxController> {
  const UpdateTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();

    return Scaffold(
        appBar: AppBar(
          title: const Text('UpdateTxView'),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
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
                  decoration: InputDecoration(
                      suffixText: "kg ", border: OutlineInputBorder()),
                ),
                SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateTxDoc();
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
