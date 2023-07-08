import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../../../../utils/widget.dart';
import '../../../routes/app_pages.dart';

class TrxView extends GetView<AdminTxController> {
  const TrxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Transaction'),
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
                leading: Icon(Icons.supervisor_account_outlined),
                onTap: () => Get.offAllNamed(Routes.HOME)),
            ListTile(
                title:
                    const Text('Log out', style: TextStyle(color: Colors.red)),
                onTap: () => controller.signOut()),
          ],
        ),
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
                String groupKey = DateFormat('d MMMM').format(date);
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
                  return DateFormat('d MMMM').format(date);
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
                  DateTime date1 = DateFormat('d MMMM').parse(group1, true);
                  DateTime date2 = DateFormat('d MMMM').parse(group2, true);
                  return date1.compareTo(date2);
                },
                itemBuilder: (context, element) {
                  return Card(
                    child: ListTile(
                        title: Text(element['name']),
                        subtitle: Text('${element['weight']} kg'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          '+${formatCurrency.format(element['price'])}',
                          style: TextStyle(fontSize: 14, color: Colors.green),
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
                                  text: "Edit",
                                  Pressed: () => Get.toNamed(Routes.UPDATETX,
                                      arguments: element['transactionID']),
                                ),
                                DeleteButton(
                                    text: "Delete",
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
