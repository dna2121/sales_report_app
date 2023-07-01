import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

class UpdateTxView extends GetView<AdminTxController> {
  const UpdateTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Transaction'),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 18),
                ),
                StreamBuilder(
                    stream: controller.streamName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading...");
                      }

                      if (snapshot.hasData) {
                        return DropdownSearch<String>(
                          clearButtonProps: ClearButtonProps(isVisible: true),
                          popupProps: PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              searchFieldProps: TextFieldProps(
                                  decoration:
                                      InputDecoration(labelText: "Search..."))),
                          items: snapshot.data!,
                          selectedItem: controller.selectedName,
                          onChanged: (value) async {
                            controller.selectedName = value;
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(height: 17),
                Text(
                  'Price',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: controller.priceC,
                  validator: controller.validator,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: "Rp. ", border: OutlineInputBorder()),
                ),
                SizedBox(height: 17),
                Text(
                  'Date',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: controller.dateC,
                  validator: controller.validator,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                ),
                SizedBox(height: 17),
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: controller.weightC,
                  validator: controller.validator,
                  decoration: InputDecoration(
                      suffixText: "kg ", border: OutlineInputBorder()),
                ),
                SizedBox(height: 17),
                Text(
                  'Car Number',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: controller.carC,
                  validator: controller.validator,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.characters,
                ),
                SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateTxDoc();
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
