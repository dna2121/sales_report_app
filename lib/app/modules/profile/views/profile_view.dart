import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../../../../utils/color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: StreamBuilder(
              stream: controller.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading"));
                }

                if (snapshot.hasData) {
                  var userData = snapshot.data!;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: TitleText(text: "Email")),
                          Expanded(flex: 3, child: Text(userData['email'])),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: TitleText(text: "Nama")),
                          Expanded(flex: 3, child: Text(userData['name'])),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: TitleText(text: "Nomor Ponsel")),
                          Expanded(
                              flex: 3, child: Text(userData['phoneNumber'])),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: TitleText(text: "Alamat")),
                          Expanded(flex: 3, child: Text(userData['address'])),
                        ],
                      ),
                      SizedBox(height: 50),
                      StringButton(
                        backgroundColor: AppColor.putihBtn,
                        pressed: () {
                          Get.toNamed(Routes.UPDATEPROFILE,
                              arguments: userData['id']);
                        },
                        text: "Ubah Profil",
                      ),
                      SizedBox(height: 17),
                      StringButton(
                        backgroundColor: AppColor.redBtn,
                        pressed: () {
                          controller.signOut();
                        },
                        text: "Log out",
                        color: Colors.white,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
