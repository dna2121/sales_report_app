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
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Form(
              key: controller.carsFormKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter a new car number",
                ),
                controller: controller.carsController,
                validator: controller.validator,
              ),
            ),
            SizedBox(
              height: 37,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.name.isNotEmpty
                      ? controller.addNewCar()
                      : controller.textEmpty;
                },
                child: Text("Add"),
              ),
            ),
            SizedBox(height: 10),
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
      ),
    );
  }
}
