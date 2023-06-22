import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/routes/app_pages.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              controller.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 17, 17, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Search",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      backgroundColor: Colors.white,
                      Container(
                        height: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Text("Add New Car Number"),
                              Form(
                                key: controller.carsFormKey,
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Car Number"),
                                  controller: controller.carsController,
                                  validator: controller.validator,
                                ),
                              ),
                              SizedBox(
                                height: 27,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.carsController.text.isEmpty
                                        ? controller.textEmpty
                                        : controller.addCar();
                                  },
                                  child: Text("Save"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: controller.StreamCar(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                  Container(
                                    padding: EdgeInsets.fromLTRB(17, 17, 17, 2),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.CARSEDIT,
                                            arguments: data['carID']);
                                      },
                                      child: Text("Edit"),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(17, 2, 17, 17),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.deleteCar(data["carID"]);
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }).toList(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
