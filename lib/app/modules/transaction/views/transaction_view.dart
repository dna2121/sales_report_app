// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';
import 'package:sales_report_app/utils/color.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  TransactionView({Key? key}) : super(key: key);
  TransactionController controller = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder(
              stream: controller.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!;
                  return Text(
                    'Halo, ${userData['name']}',
                  );
                } else if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              }),
          actions: [
            StreamBuilder(
              stream: controller.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!;
                  var roles = List<String>.from(userData['role']);

                  if (roles.contains('admin')) {
                    return Visibility(
                      visible: true,
                      child: IconButton(
                          onPressed: () => Get.offAllNamed(Routes.ADMIN),
                          icon: Icon(Icons.admin_panel_settings)),
                    );
                  } else {
                    return SizedBox();
                  }
                } else if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              },
            ),
            IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person),
            ),
            SizedBox(width: 14),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.boxShadow,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.boxShadow,
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: Offset(0, 50)),
                ],
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(height: 45),
                HeaderText(text: "Total Pembelian Hari Ini"),
                SizedBox(height: 25),
                StreamBuilder(
                  stream: controller.streamTxToday(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("Loading"));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: Text("Loading..."));
                    }

                    if (snapshot.hasData) {
                      List<DocumentSnapshot> documents = snapshot.data!.docs;

                      // Calculate total price
                      int totalAmount = 0;
                      documents.forEach((document) {
                        totalAmount += document['price'] as int;
                      });

                      // Format totalAmount as rupiah
                      final formatCurrency =
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
                      final formattedAmount =
                          formatCurrency.format(totalAmount);

                      return Text(
                        '$formattedAmount',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: 25),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: whiteboxDecor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(text: "Transaksi Terbaru"),
                  SizedBox(height: 7),
                  StreamBuilder(
                    stream: controller.streamTxById(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Text("Loading"));
                      }

                      if (!snapshot.hasData) {
                        return Center(child: Text("Loading..."));
                      }

                      List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return Column(
                        children: documents.map((document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          int totalPrice = data['price'];
                          final formatCurrency = NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ');
                          String formattedAmount =
                              formatCurrency.format(totalPrice);

                          Timestamp timestamp = data['date'] as Timestamp;
                          DateTime date = timestamp.toDate();
                          String tanggal = DateFormat('d MMM ').format(date);

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.amber.shade300,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              formattedAmount,
                              style:
                                  TextStyle(fontSize: 14, color: AppColor.body),
                            ),
                            title: Text('${data['weight']} kg'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['carNumber'],
                                    style: TextStyle(color: Colors.grey)),
                                Text(tanggal,
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey.shade300),
                  SizedBox(height: 10),
                  StringButton(pressed: () {}, text: "Daftar Transaksi"),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
