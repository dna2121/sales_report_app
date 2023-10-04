import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/cars/views/cars_view.dart';
import 'package:sales_report_app/app/modules/transaction/views/transaction_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
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
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [TransactionView(), CarsView()],
        ),
      ),
    );
  }
}
