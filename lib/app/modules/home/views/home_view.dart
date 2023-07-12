import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/cars/views/cars_view.dart';
import 'package:sales_report_app/app/modules/transaction/views/transaction_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => ClipRRect(
          child: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fire_truck_outlined),
                activeIcon: Icon(Icons.fire_truck),
                label: 'Car Number',
              ),
            ],
          ),
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
