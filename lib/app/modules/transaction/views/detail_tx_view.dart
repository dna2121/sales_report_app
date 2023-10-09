import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:sales_report_app/utils/color.dart';

class DetailTxView extends GetView<TransactionController> {
  const DetailTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: controller.getDetailTx(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            if (!snapshot.hasData) {
              return Center(child: Text("There is no data"));
            }

            if (snapshot.hasData) {
              var userData = snapshot.data!;

              int totalPrice = userData['price'];
              final formatCurrency =
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
              String formattedAmount = formatCurrency.format(totalPrice);

              Timestamp timestamp = userData['date'] as Timestamp;
              DateTime date = timestamp.toDate();
              String tanggal = DateFormat('d MMM yyyy').format(date);

              return Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(19, 50, 19, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 1, // Border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 1,
                          blurRadius: 70,
                          offset: Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              color: AppColor.boxShadow,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            userData['name'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          formattedAmount,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 14),
                        Divider(thickness: 0.5),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Berat",
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 132, 143, 1)),
                            )),
                            Expanded(
                                child: Text(
                              userData['weight'].toString() + " kg",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Tanggal",
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 132, 143, 1)),
                            )),
                            Expanded(
                                child: Text(
                              tanggal,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Nomor Kendaraan",
                              style: TextStyle(
                                  color: Color.fromRGBO(127, 132, 143, 1)),
                            )),
                            Expanded(
                                child: Text(
                              userData['carNumber'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    )),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
