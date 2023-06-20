import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/views/admintx_view.dart';
import 'package:sales_report_app/app/modules/admin/views/supplier_view.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
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
                label: 'AdminTx',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_2_outlined),
                activeIcon: Icon(Icons.groups_2),
                label: 'Farmer',
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [AdminTxView(), SupplierView()],
        ),
      ),
    );
  }
}
