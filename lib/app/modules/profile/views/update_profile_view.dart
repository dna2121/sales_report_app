import 'package:flutter/material.dart';

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
        title: const Text('Edit profile'),
        centerTitle: true,
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
                    Expanded(child: TitleText(text: "Name")),
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
                    Expanded(child: TitleText(text: "Phone Number")),
                    Expanded(
                      flex: 3,
                      child: InputField(
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
                    Expanded(child: TitleText(text: "Address")),
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
