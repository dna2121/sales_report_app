import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';

import '../../../../utils/widget.dart';
import '../controllers/user_transaction_controller.dart';

class UserTxlistView extends GetView<UserTransactionController> {
  const UserTxlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Transaksi'),
        // centerTitle: true,
      ),
      body: StreamBuilder(
          stream: controller.streamTxById(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            if (!snapshot.hasData) {
              return Center(child: Text("There is no data"));
            }

            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              Map<String, int> groupTotalPrices = {};

              documents.forEach((document) {
                Timestamp timestamp = document['date'] as Timestamp;
                DateTime date = timestamp.toDate();
                String groupKey = DateFormat('d MMM yyy').format(date);
                int price = document['price'] as int;

                if (groupTotalPrices.containsKey(groupKey)) {
                  groupTotalPrices[groupKey] =
                      groupTotalPrices[groupKey]! + price;
                } else {
                  groupTotalPrices[groupKey] = price;
                }
              });

              final formatCurrency =
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

              return GroupedListView(
                elements: snapshot.data!.docs,
                order: GroupedListOrder.DESC,
                groupBy: (element) {
                  Timestamp timestamp = element['date'] as Timestamp;
                  DateTime date = timestamp.toDate();
                  return DateFormat('d MMM yyy').format(date);
                },
                groupSeparatorBuilder: (value) {
                  String groupKey = value;
                  int totalPrice = groupTotalPrices[groupKey]!;
                  String formattedAmount = formatCurrency.format(totalPrice);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(19, 13, 19, 10),
                    child: Row(
                      children: [
                        Expanded(child: HeaderText(text: value)),
                        TitleText(text: formattedAmount),
                      ],
                    ),
                  );
                },
                groupComparator: (group1, group2) {
                  DateTime date1 = DateFormat('d MMM yyy').parse(group1, true);
                  DateTime date2 = DateFormat('d MMM yyy').parse(group2, true);
                  return date1.compareTo(date2);
                },
                itemBuilder: (context, element) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAILTX,
                              arguments: element['transactionID']);
                        },
                        highlightColor: Colors.transparent,
                        // splashColor: Colors.white,
                        child: Container(
                          decoration: cardboxDecor(),
                          child: ListTile(
                            title: Text('${element['weight']} kg'),
                            subtitle: Text(element['carNumber'],
                                style: TextStyle(color: Colors.grey)),
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 173, 83, 189),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              '+${formatCurrency.format(element['price'])}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox();
          }),
    );
  }
}


// return Card(
//                       child: ListTile(
//                     title: Text('${element['weight']} kg'),
//                     subtitle: Text(element['carNumber'],
//                         style: TextStyle(color: Colors.grey)),
//                     leading: CircleAvatar(
//                       backgroundColor: const Color.fromARGB(255, 173, 83, 189),
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                     ),
//                     trailing: Text(
//                       '+${formatCurrency.format(element['price'])}',
//                       style: TextStyle(fontSize: 14, color: Colors.green),
//                     ),
//                     onTap: () => Get.toNamed(Routes.DETAILTX,
//                         arguments: element['transactionID']),
//                   ));