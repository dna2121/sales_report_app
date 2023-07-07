import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/supplier_controller.dart';

import '../../../../utils/widget.dart';

class UpdateSupplierView extends GetView<SupplierController> {
  const UpdateSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchUsersDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Farmer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TitleText(text: "Email")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        readOnly: true,
                        controller: controller.emailC,
                        validator: controller.validator,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: TitleText(text: "Name")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        controller: controller.nameC,
                        validator: controller.validator,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: TitleText(text: "Phone Number")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        controller: controller.phoneC,
                        validator: controller.validator,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: TitleText(text: "Address")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        controller: controller.addressC,
                        validator: controller.validator,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                StringButton(
                  pressed: () {
                    controller.updateUserDoc();
                  },
                  text: "Save",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}