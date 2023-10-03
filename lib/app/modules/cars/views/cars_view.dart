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
        title: const Text('Nomor Kendaraan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                      child: InputField(
                    hintText: "Pencarian",
                    controller: controller.searchC,
                    onChanged: controller.onSearchTextChanged,
                    textCapitalization: TextCapitalization.characters,
                  )),
                  SizedBox(width: 7),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      color: AppColor.body,
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
                                  HeaderText(text: "Tambah Nomor Mobil"),
                                  SizedBox(height: 11),
                                  Form(
                                    key: controller.carsFormKey,
                                    child: InputField(
                                        hintText: "cth: KB 1637 WT",
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        controller: controller.carsController,
                                        validator: controller.validator),
                                  ),
                                  SizedBox(
                                    height: 27,
                                  ),
                                  StringButton(
                                    text: "Simpan",
                                    color: Colors.white,
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
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(
              () {
                final snapshot = controller.carSnapshot.value;
                if (snapshot == null) {
                  return Text("Loading");
                }

                List<Color> avatarColors = [
                  Colors.blue.shade300,
                  Colors.green.shade300,
                  Colors.purple.shade300,
                  Colors.red.shade300
                ];

                int colorIndex = 0;

                return ListView(
                  children: snapshot.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    Color backgroundColor =
                        avatarColors[colorIndex % avatarColors.length];

                    // Increment the colorIndex for the next iteration
                    colorIndex++;

                    return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: backgroundColor,
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
                                    text: "Hapus",
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
