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
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Search",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      backgroundColor: Colors.white,
                      SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(17),
                            child: Column(
                              children: [
                                Text("Add Supplier"),
                                Form(
                                  key: controller.supplFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: "Name"),
                                        controller: controller.nameController,
                                        validator: controller.validator,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Phone Number"),
                                        controller:
                                            controller.phoneNumberController,
                                        validator: controller.validator,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Address"),
                                        controller:
                                            controller.addressController,
                                        validator: controller.validator,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 27,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.nameController.text.isEmpty |
                                              controller.phoneNumberController
                                                  .text.isEmpty |
                                              controller.addressController.text
                                                  .isEmpty
                                          ? controller.textEmpty
                                          : controller.addNewUser();
                                    },
                                    child: Text("Save"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
