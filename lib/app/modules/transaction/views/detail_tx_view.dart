import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:sales_report_app/utils/widget.dart';

class DetailTxView extends GetView<TransactionController> {
  const DetailTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
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
              String tanggal = DateFormat('d MMMM yyyy').format(date);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: HeaderText(text: "Name"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: StringField(text: userData['name']),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: HeaderText(text: "Price"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: StringField(text: formattedAmount),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: HeaderText(text: "Date"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: StringField(text: tanggal),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: HeaderText(text: "Car Number"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: StringField(text: userData['carNumber']),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: HeaderText(text: "Weight"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                    child: StringField(
                        text: userData['weight'].toString() + " kg"),
                  ),
                  // SizedBox(height: 18),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                  //   child: HeaderText(text: "TransactionID"),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                  //   child: StringField(text: userData['transactionID']),
                  // ),
                  SizedBox(height: 35),
                ],
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
