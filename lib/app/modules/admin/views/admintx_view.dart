import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../../../routes/app_pages.dart';

class AdminTxView extends GetView<AdminTxController> {
  AdminTxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.weightC.clear();
          controller.priceC.clear();
          controller.dateC.clear();
          controller.selectedName = null;
          controller.selectedCarnum = null;

          Get.toNamed(Routes.NEWTX);
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                'Hi, Admin.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(),
            ListTile(
              title: const Text('User Form'),
              onTap: () {
                Get.offAllNamed(Routes.HOME);
              },
            ),
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                controller.signOut();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: controller.streamTx(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if (snapshot.hasData) {
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                            title: Text(data['name']),
                            subtitle: Text('${data['weight']} kg'),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(Icons.person),
                            ),
                            trailing: Text(
                              '+Rp ${data['price']}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.ADMDETAILTX,
                                  arguments: data['transactionID']);
                            },
                            onLongPress: () {
                              Get.bottomSheet(
                                backgroundColor: Colors.white,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(17, 17, 17, 2),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.UPDATETX,
                                              arguments: data['transactionID']);
                                        },
                                        child: Text("Edit"),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(17, 2, 17, 17),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller
                                              .deleteTx(data["transactionID"]);
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
                  }
                  return SizedBox();
                }),
          )
        ],
      ),
    );
  }
}
