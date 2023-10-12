// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/home/controllers/home_controller.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/admin_transaction_controller.dart';
import 'package:sales_report_app/app/modules/transaction/views/user_transaction_view.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';

import '../../transaction/controllers/user_transaction_controller.dart';
import '../../transaction/views/admin_transaction_view.dart';

class TransactionView extends GetView<HomeController> {
  TransactionView({Key? key}) : super(key: key);
  UserTransactionController userCtrl = Get.put(UserTransactionController());
  AdminTransactionController adminCtrl = Get.put(AdminTransactionController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder(
              stream: controller.getRole(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!;
                  var roles = List<String>.from(userData['role']);

                  if (roles.contains('admin')) {
                    return Text("Admin");
                  } else {
                    return Text(
                      'Halo, ${userData['name']}',
                    );
                  }
                } else if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              }),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person),
            ),
            SizedBox(width: 14),
          ]),
      body: StreamBuilder(
          stream: controller.getRole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data!;
              var roles = List<String>.from(userData['role']);

              if (roles.contains('admin')) {
                return AdminTransactionView();
              } else {
                return UserTransactionView();
              }
            } else if (snapshot.hasError) {
              return SizedBox();
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
