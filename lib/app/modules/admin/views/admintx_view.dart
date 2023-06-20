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
        title: const Text('Admin'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.NEWTX),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            child: Text('User form'),
          ),
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
                          subtitle: Text('${data['weight']} ton'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person),
                          ),
                          trailing: Text(
                            '+Rp ${data['price']}',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        );
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
