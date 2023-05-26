import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        centerTitle: true,
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
                      SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(17),
                            child: Column(
                              children: [
                                Text("Add Supplier"),
                                Form(
                                  key: controller.supplFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: "Name"),
                                        controller: controller.nameController,
                                        validator: controller.validator,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Phone Number"),
                                        controller:
                                            controller.phoneNumberController,
                                        validator: controller.validator,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Address"),
                                        controller:
                                            controller.addressController,
                                        validator: controller.validator,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 27,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.nameController.text.isEmpty |
                                              controller.phoneNumberController
                                                  .text.isEmpty |
                                              controller.addressController.text
                                                  .isEmpty
                                          ? controller.textEmpty
                                          : controller.addNewUser();
                                    },
                                    child: Text("Save"),
                                  ),
                                ),
                              ],
                            ),
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
                stream: controller.getUser(),
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
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.person),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['phoneNumber']),
                        onTap: () {
                          Get.bottomSheet(
                              backgroundColor: Colors.white,
                              SingleChildScrollView(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(17.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data['name'],
                                            style: TextStyle(fontSize: 21)),
                                        SizedBox(height: 17),
                                        Text("Phone Number"),
                                        Text(data['phoneNumber']),
                                        SizedBox(height: 17),
                                        Text("Address"),
                                        Text(data['address']),
                                        SizedBox(height: 17),
                                        Text("Cars"),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
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
