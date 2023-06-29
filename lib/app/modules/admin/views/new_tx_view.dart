import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

class NewTxView extends GetView<AdminTxController> {
  const NewTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Transaction'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.trxFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: "Rp. ",
                  label: Text("Harga"),
                ),
                controller: controller.priceC,
                validator: controller.validator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Tanggal"),
                controller: controller.dateC,
                validator: controller.validator,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await controller.chooseDate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixText: " kilogram",
                  label: Text("Berat"),
                ),
                controller: controller.weightC,
                validator: controller.validator,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.addNewTx();
                },
                child: Text("Save"),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
