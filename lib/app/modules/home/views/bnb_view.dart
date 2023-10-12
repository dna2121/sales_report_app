import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/cars/views/cars_view.dart';
import 'package:sales_report_app/app/modules/home/controllers/home_controller.dart';

import '../../cars/controllers/cars_controller.dart';
import '../../supplier/controllers/supplier_controller.dart';
import '../../supplier/views/supplier_view.dart';

// ignore: must_be_immutable
class BnbView extends GetView<HomeController> {
  BnbView({Key? key}) : super(key: key);
  CarsController carsController = Get.put(CarsController());
  SupplierController supplierController = Get.put(SupplierController());
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
                  return Text("Daftar Petani");
                } else {
                  return Text(
                    'Nomor Kendaraan',
                  );
                }
              } else if (snapshot.hasError) {
                return SizedBox();
              } else {
                return SizedBox();
              }
            }),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: controller.getRole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data!;
              var roles = List<String>.from(userData['role']);

              if (roles.contains('admin')) {
                return SupplierView();
              } else {
                return CarsView();
              }
            } else if (snapshot.hasError) {
              return SizedBox();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
