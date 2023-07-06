import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 17, 17, 1),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                    child: Text("Create a new account"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
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
                                      padding: const EdgeInsets.all(17.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              roles.contains('admin')
                                                  ? '${data['name']} (Admin)'
                                                  : '${data['name']}',
                                              style: TextStyle(fontSize: 21)),
                                          SizedBox(height: 17),
                                          Text("Phone Number"),
                                          Text(data['phoneNumber']),
                                          SizedBox(height: 17),
                                          Text("Address"),
                                          Text(data['address']),
                                          SizedBox(height: 17),
                                          Text("Cars"),
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
                                  // Container(
                                  //   padding:
                                  //       EdgeInsets.fromLTRB(17, 17, 17, 2),
                                  //   width: double.infinity,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       Get.toNamed(Routes.UPDATETX,
                                  //           arguments: data['transactionID']);
                                  //     },
                                  //     child: Text("Edit"),
                                  //   ),
                                  // ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(17, 2, 17, 17),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.deleteUser(data["id"]);
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ),
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
