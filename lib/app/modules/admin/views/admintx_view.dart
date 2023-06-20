import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../../../routes/app_pages.dart';

class AdminTxView extends GetView<AdminTxController> {
  AdminTxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.trxFormKey,
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(Routes.HOME);
                },
                child: Text('User form'),
              ),
              StreamBuilder(
                  stream: controller.streamName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    }

                    if (snapshot.hasData) {
                      return DropdownSearch<String>(
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: "Name")),
                        clearButtonProps: ClearButtonProps(isVisible: true),
                        popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                            searchFieldProps: TextFieldProps(
                                decoration:
                                    InputDecoration(labelText: "Search..."))),
                        items: snapshot.data!,
                        selectedItem: controller.selectedName,
                        onChanged: (value) {
                          controller.selectedName = value;
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              // StreamBuilder(
              //     stream: controller.streamCar(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Text("Loading...");
              //       }

              //       if (snapshot.hasData) {
              //         return DropdownSearch<String>(
              //           dropdownDecoratorProps: DropDownDecoratorProps(
              //               dropdownSearchDecoration:
              //                   InputDecoration(labelText: "Plat Mobil")),
              //           clearButtonProps: ClearButtonProps(isVisible: true),
              //           popupProps: PopupProps.menu(
              //               showSearchBox: true,
              //               showSelectedItems: true,
              //               searchFieldProps: TextFieldProps(
              //                   decoration:
              //                       InputDecoration(labelText: "Search..."))),
              //           items: snapshot.data!,
              //           // selectedItem: controller.selectedCar,
              //           onChanged: (value) {
              //             // controller.selectedCar = value;
              //             print(value);
              //           },
              //         );
              //       } else {
              //         return CircularProgressIndicator();
              //       }
              //     }),
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Harga"),
                ),
                controller: controller.priceController,
                validator: controller.validator,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Berat dalam ton"),
                ),
                controller: controller.weightController,
                validator: controller.validator,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.addNewTx();
                },
                child: Text("Save"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                    stream: controller.streamTx(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['name']),
                              subtitle: Text('${data['weight']} ton'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(Icons.person),
                              ),
                              trailing: Text(
                                '+Rp ${data['price']}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return SizedBox();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
