// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/home/controllers/home_controller.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/admin_transaction_controller.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';
import 'package:sales_report_app/utils/color.dart';
import 'package:sales_report_app/utils/widget.dart';

import '../controllers/user_transaction_controller.dart';

class UserTransactionView extends GetView<UserTransactionController> {
  UserTransactionView({Key? key}) : super(key: key);
  UserTransactionController controller = Get.put(UserTransactionController());
  AdminTransactionController adminCtrl = Get.put(AdminTransactionController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                HeaderText(text: "Penjualan Hari Ini"),
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
            Center(
              child: Container(
                width: 500,
                margin: EdgeInsets.symmetric(horizontal: 22),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: whiteboxDecor(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText(
                      text: "Transaksi Terbaru",
                      color: Colors.white,
                    ),
                    SizedBox(height: 7),
                    StreamBuilder(
                      stream: controller.stream3TxById(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              title: Text(
                                '${data['weight']} kg',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['carNumber'],
                                      style: TextStyle(color: Colors.white)),
                                  Text(tanggal,
                                      style: TextStyle(color: Colors.white)),
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
                    StringButton(
                        backgroundColor: AppColor.putihBtn,
                        pressed: () => Get.toNamed(Routes.USERTXLIST),
                        text: "Daftar Transaksi"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
