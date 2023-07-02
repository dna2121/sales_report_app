import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

class TrxView extends GetView<AdminTxController> {
  const TrxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrxView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: controller.streamTx(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (!snapshot.hasData) {
              Text("Loading...");
            }

            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!.docs;

              // Calculate total price
              totalAmount = 0;
              documents.forEach((document) {
                totalAmount += document['price'] as int;
              });

              // Format totalAmount as rupiah
              final formatCurrency =
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
              final formattedAmount = formatCurrency.format(totalAmount);

              return Column(
                children: [
                  Text('Total Price: $formattedAmount'),
                  Expanded(
                    child: GroupedListView(
                      elements: snapshot.data!.docs,
                      order: GroupedListOrder.DESC,
                      groupBy: (element) {
                        Timestamp timestamp = element['date'] as Timestamp;
                        DateTime date = timestamp.toDate();
                        // return date.toString().substring(0, 10);
                        return DateFormat('d MMMM').format(date);
                      },
                      groupSeparatorBuilder: (String value) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            // SizedBox(),
                            Text(
                              value,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      groupComparator: (group1, group2) {
                        DateTime date1 =
                            DateFormat('d MMMM').parse(group1, true);
                        DateTime date2 =
                            DateFormat('d MMMM').parse(group2, true);
                        return date1.compareTo(date2);
                      },
                      itemBuilder: (context, element) {
                        return ListTile(
                          title: Text(element['name']),
                          subtitle: Text('${element['weight']} kg'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person),
                          ),
                          trailing: Text(
                            '+${formatCurrency.format(element['price'])}',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          }),
    );
  }
}
