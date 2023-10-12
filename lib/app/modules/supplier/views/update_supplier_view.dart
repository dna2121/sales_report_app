import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../utils/widget.dart';
import '../controllers/supplier_controller.dart';

class UpdateSupplierView extends GetView<SupplierController> {
  const UpdateSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchUsersDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Data Petani'),
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
                    Expanded(child: TitleText(text: "Nama")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        controller: controller.nameC,
                        validator: controller.validator,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: TitleText(text: "Nomor Ponsel")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(13)
                        ],
                        controller: controller.phoneC,
                        validator: controller.validator,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: TitleText(text: "Alamat")),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        controller: controller.addressC,
                        validator: controller.validator,
                        maxLines: 4,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                StringButton(
                  color: Colors.white,
                  pressed: () {
                    controller.updateUserDoc();
                  },
                  text: "Simpan",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
