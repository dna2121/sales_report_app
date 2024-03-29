import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

class UpdateProfileView extends GetView<ProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchUsersDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.userFormKey,
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
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
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
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
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
