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
                        key: controller.popupBuilderKey,
                        popupProps: PopupProps.menu(
                            showSearchBox: true, showSelectedItems: true),
                        items: snapshot.data!,
                        selectedItem: controller.selectedValue,
                        onChanged: (value) {
                          controller.selectedValue = value!;
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              TextFormField(
                decoration: InputDecoration(
                  label: Text("harga"),
                ),
                controller: controller.hargaController,
                validator: controller.validator,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.addTrc();
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
