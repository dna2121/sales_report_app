import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../../../../utils/color.dart';
import '../../../routes/app_pages.dart';
import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petani'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(17, 17, 17, 1),
              child: StringButton(
                  backgroundColor: AppColor.putihBtn,
                  pressed: () => Get.toNamed(Routes.SIGNUP),
                  text: "Buat Akun Petani")),
          Expanded(
            child: StreamBuilder(
                stream: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading"));
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      var roles = List<String>.from(data['role']);

                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person),
                          ),
                          title: Text(roles.contains('admin')
                              ? '${data['name']} (Admin)'
                              : '${data['name']}'),
                          subtitle: Text(data['phoneNumber']),
                          onTap: () {
                            Get.bottomSheet(
                                backgroundColor: Colors.white,
                                SingleChildScrollView(
                                  child: Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 26, horizontal: 18),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          HeaderText(
                                            text: roles.contains('admin')
                                                ? '${data['name']} (Admin)'
                                                : '${data['name']}',
                                          ),
                                          SizedBox(height: 17),
                                          TitleText(text: "Nomor Handphone"),
                                          Text(data['phoneNumber']),
                                          SizedBox(height: 17),
                                          TitleText(text: "Alamat"),
                                          Text(data['address']),
                                          SizedBox(height: 17),
                                          TitleText(text: "Email"),
                                          Text(data['email']),
                                          SizedBox(height: 17),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          onLongPress: () {
                            Get.bottomSheet(
                              backgroundColor: Colors.white,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  EditButton(
                                      text: "Edit",
                                      Pressed: () {
                                        Get.toNamed(Routes.UPDATESUPPLIER,
                                            arguments: data['id']);
                                      }),
                                  DeleteButton(
                                      text: "Hapus",
                                      Pressed: () {
                                        controller.deleteUser(data["id"]);
                                      })
                                ],
                              ),
                            );
                          });
                    }).toList(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
