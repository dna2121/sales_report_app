// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  TransactionView({Key? key}) : super(key: key);
  TransactionController controller = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Hi ${AuthController.instance.firebaseAuth.currentUser!.displayName.toString()}',
              style: TextStyle(fontSize: 20),
            ),
            StreamBuilder(
              stream: controller.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!;
                  var id = userData['id'];

                  return Visibility(
                    visible:
                        id == "zzY6CyiF0lWkvDFTZx011tSiBr22" ? true : false,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.ADMIN);
                      },
                      child: Text('Admin form'),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              },
            ),
            Expanded(
              child: StreamBuilder(
                  stream: controller.streamTxById(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
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
      ),
    );
  }
}
