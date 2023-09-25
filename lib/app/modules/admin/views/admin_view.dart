import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/views/supplier_view.dart';
import 'package:sales_report_app/app/modules/admin/views/trx_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                icon: FaIcon(FontAwesomeIcons.house),
                label: '—',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  size: 30,
                ),
                label: '—',
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [TrxView(), SupplierView()],
        ),
      ),
    );
  }
}
