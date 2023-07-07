import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/utils/color.dart';

import '../../../../utils/widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cars_controller.dart';

// ignore: must_be_immutable
class CarsView extends GetView<CarsController> {
  CarsView({Key? key}) : super(key: key);

  CarsController controller = Get.put(CarsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 17, 17, 1),
            child: Row(
              children: [
                Expanded(
                    child: InputField(
                  hintText: "Search...",
                  controller: controller.searchC,
                  onChanged: controller.onSearchTextChanged,
                  textCapitalization: TextCapitalization.characters,
                )),
                SizedBox(width: 7),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColor.grey2,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    color: AppColor.green,
                    onPressed: () {
                      controller.carsController.clear();
                      Get.bottomSheet(
                        backgroundColor: Colors.white,
                        Container(
                          height: 220,
                          child: Padding(
                            padding: const EdgeInsets.all(17),
                            child: Column(
                              children: [
                                HeaderText(text: "Add New Car Number"),
                                SizedBox(height: 11),
                                Form(
                                  key: controller.carsFormKey,
                                  child: InputField(
                                      hintText: "ex: KB 1637 WT",
                                      controller: controller.carsController,
                                      validator: controller.validator),
                                ),
                                SizedBox(
                                  height: 27,
                                ),
                                StringButton(
                                  text: "Save",
                                  pressed: () {
                                    controller.carsController.text.isEmpty
                                        ? controller.textEmpty
                                        : controller.addCar();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final snapshot = controller.carSnapshot.value;
                if (snapshot == null) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(
                            Icons.fire_truck,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['carNumber']),
                        onLongPress: () {
                          Get.bottomSheet(
                            backgroundColor: Colors.white,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                EditButton(
                                  text: "Edit",
                                  Pressed: () => Get.toNamed(Routes.CARSEDIT,
                                      arguments: data['carID']),
                                ),
                                DeleteButton(
                                    text: "Delete",
                                    Pressed: () =>
                                        controller.deleteCar(data["carID"])),
                              ],
                            ),
                          );
                        });
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
