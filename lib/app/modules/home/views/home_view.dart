// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sales_report_app/app/modules/home/views/bnb_view.dart';
import 'package:sales_report_app/app/modules/home/views/transaction_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StreamBuilder(
          stream: controller.getRole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data!;
              var roles = List<String>.from(userData['role']);

              if (roles.contains('admin')) {
                return Obx(
                  () => BottomNavigationBar(
                    onTap: controller.changeTabIndex,
                    currentIndex: controller.tabIndex.value,
                    items: [
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.house),
                        label: "—",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.group,
                          size: 30,
                        ),
                        label: "—",
                      ),
                    ],
                  ),
                );
              } else {
                return Obx(
                  () => BottomNavigationBar(
                    onTap: controller.changeTabIndex,
                    currentIndex: controller.tabIndex.value,
                    items: [
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.house),
                        label: "—",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.car),
                        label: "—",
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return SizedBox();
            } else {
              return SizedBox();
            }
          }),
      body: Obx(
        () => IndexedStack(
          index: Get.find<HomeController>().tabIndex.value,
          children: [TransactionView(), BnbView()],
        ),
      ),
    );
  }
}
