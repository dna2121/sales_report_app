import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/profile/controllers/profile_controller.dart';

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
      body: Form(
        key: controller.userFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text("Email")),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: controller.emailC,
                        validator: controller.validator,
                        readOnly: true,
                      )),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text("Name")),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: controller.nameC,
                        validator: controller.validator,
                      )),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text("Phone Number")),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: controller.phoneC,
                        validator: controller.validator,
                      )),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text("Address")),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: controller.addressC,
                        validator: controller.validator,
                        maxLines: 3,
                      )),
                ],
              ),
              SizedBox(height: 18),
              Container(
                padding: EdgeInsets.all(17),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateUserDoc();
                  },
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
