import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
