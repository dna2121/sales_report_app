// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';
import 'package:sales_report_app/utils/widget.dart';

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
      drawer: Drawer(
        child: ListView(
          children: [
            StreamBuilder(
                stream: controller.getRole(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userData = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: HeaderText(
                        text: 'Hi, ${userData['name']}.',
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return SizedBox();
                  } else {
                    return SizedBox();
                  }
                }),
            Divider(),
            StreamBuilder(
              stream: controller.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!;
                  var roles = List<String>.from(userData['role']);

                  if (roles.contains('admin')) {
                    return Visibility(
                      visible: true,
                      child: ListTile(
                        title: const Text('Admin Page'),
                        leading: Icon(Icons.admin_panel_settings_outlined),
                        onTap: () {
                          Get.offAllNamed(Routes.ADMIN);
                        },
                      ),
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
            ListTile(
              title: const Text('Profile'),
              leading: Icon(Icons.person_outline),
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
            ),
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                controller.signOut();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
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
                          String formattedAmount =
                              formatCurrency.format(totalPrice);

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
                          DateTime date1 =
                              DateFormat('d MMMM').parse(group1, true);
                          DateTime date2 =
                              DateFormat('d MMMM').parse(group2, true);
                          return date1.compareTo(date2);
                        },
                        itemBuilder: (context, element) {
                          return Card(
                            child: ListTile(
                              title: Text(element['name']),
                              subtitle: Text('${element['weight']} kg'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              trailing: Text(
                                '+${formatCurrency.format(element['price'])}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                              onTap: () => Get.toNamed(Routes.DETAILTX,
                                  arguments: element['transactionID']),
                            ),
                          );
                        },
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
