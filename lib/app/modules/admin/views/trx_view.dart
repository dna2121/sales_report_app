import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../../../../utils/color.dart';
import '../../../../utils/widget.dart';
import '../../../routes/app_pages.dart';

class TrxView extends GetView<AdminTxController> {
  const TrxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(102, 85, 184, 1),
        child: Icon(Icons.add),
        onPressed: () {
          controller.weightC.clear();
          controller.priceC.clear();
          controller.dateC.clear();
          controller.selectedName = null;
          controller.selectedCarnum = null;

          Get.toNamed(Routes.NEWTX);
        },
      ),
      body: StreamBuilder(
          stream: controller.streamTx(),
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
                String groupKey = DateFormat('d MMMM yyy').format(date);
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
                  return DateFormat('d MMMM yyy').format(date);
                },
                groupSeparatorBuilder: (value) {
                  String groupKey = value;
                  int totalPrice = groupTotalPrices[groupKey]!;
                  String formattedAmount = formatCurrency.format(totalPrice);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(19, 13, 19, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                )),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    color: Color.fromRGBO(85, 184, 179, 1),
                                    child: Text(
                                      formattedAmount,
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                        )
                      ],
                    ),
                  );
                },
                groupComparator: (group1, group2) {
                  DateTime date1 = DateFormat('d MMMM yyy').parse(group1, true);
                  DateTime date2 = DateFormat('d MMMM yyy').parse(group2, true);
                  return date1.compareTo(date2);
                },
                itemBuilder: (context, element) {
                  return Card(
                    child: ListTile(
                        title: Text(element['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${element['weight']} kg',
                                style: TextStyle(color: Colors.grey)),
                            Text(element['carNumber'],
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColor.tosca,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        trailing: Text(
                          '+${formatCurrency.format(element['price'])}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(85, 184, 179, 1)),
                        ),
                        onTap: () => Get.toNamed(Routes.ADMDETAILTX,
                            arguments: element['transactionID']),
                        onLongPress: () {
                          Get.bottomSheet(
                            backgroundColor: Colors.white,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                EditButton(
                                  text: "Ubah",
                                  Pressed: () => Get.toNamed(Routes.UPDATETX,
                                      arguments: element['transactionID']),
                                ),
                                DeleteButton(
                                    text: "Hapus",
                                    Pressed: () => controller
                                        .deleteTx(element["transactionID"])),
                              ],
                            ),
                          );
                        }),
                  );
                },
              );
            }
            return SizedBox();
          }),
    );
  }
}
