import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                        height: 250,
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
                                        : controller.addNewCar();
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
                stream: controller.getCars(),
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
                        title: Text(data['carNumber']),
                      );
                    }).toList(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
