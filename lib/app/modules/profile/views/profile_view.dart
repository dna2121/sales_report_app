import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder(
              stream: controller.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                
                if (snapshot.hasData) {
                  var userData = snapshot.data!;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Email")),
                          Expanded(flex: 3, child: Text(userData['email'])),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: Text("Name")),
                          Expanded(flex: 3, child: Text(userData['name'])),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: Text("Phone Number")),
                          Expanded(
                              flex: 3, child: Text(userData['phoneNumber'])),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text("Address")),
                          Expanded(flex: 3, child: Text(userData['address'])),
                        ],
                      ),
                      SizedBox(height: 18),
                      Container(
                        padding: EdgeInsets.all(17),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.UPDATEPROFILE,
                                arguments: userData['id']);
                          },
                          child: Text("Edit Profile"),
                        ),
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
