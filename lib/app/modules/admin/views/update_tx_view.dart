import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';

import '../../../../utils/color.dart';
import '../../../../utils/widget.dart';

class UpdateTxView extends GetView<AdminTxController> {
  const UpdateTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();
    DateTime initialValue =
        DateTime.tryParse(controller.dateC.text) ?? DateTime.now();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Transaction'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(text: "TransactionID"),
                  SizedBox(height: 7),
                  InputField(
                    readOnly: true,
                    controller: controller.trxidC,
                  ),
                  SizedBox(height: 17),
                  TitleText(text: "Name"),
                  SizedBox(height: 7),
                  StreamBuilder(
                      stream: controller.streamName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        }

                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColor.grey2,
                                borderRadius: BorderRadius.circular(7)),
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: "Select a name",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(11)),
                              ),
                              clearButtonProps:
                                  ClearButtonProps(isVisible: true),
                              popupProps: PopupProps.dialog(
                                showSearchBox: true,
                                showSelectedItems: true,
                                dialogProps: DialogProps(
                                  backgroundColor: AppColor.background,
                                  contentPadding:
                                      EdgeInsetsDirectional.symmetric(
                                          vertical: 11),
                                ),
                                searchFieldProps: TextFieldProps(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 12),
                                  decoration: InputDecoration(
                                      hintText: "Search...",
                                      contentPadding: EdgeInsets.all(11)),
                                ),
                              ),
                              items: snapshot.data!,
                              selectedItem: controller.selectedName,
                              validator: controller.validator,
                              onChanged: (value) async {
                                controller.selectedName = value;
                                String? userId =
                                    await controller.getUserIdFromName(value!);

                                controller.carNumberStream =
                                    controller.streamCarNumber(userId!);
                              },
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  SizedBox(height: 17),
                  TitleText(text: "Price"),
                  SizedBox(height: 7),
                  InputField(
                    keyboardType: TextInputType.number,
                    prefixText: "Rp. ",
                    hintText: "Enter price",
                    controller: controller.priceC,
                    validator: controller.validator,
                  ),
                  SizedBox(height: 17),
                  TitleText(text: "Date"),
                  SizedBox(height: 7),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.grey2,
                        borderRadius: BorderRadius.circular(7)),
                    child: DateTimeFormField(
                      mode: DateTimeFieldPickerMode.date,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(11),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.event_note),
                      ),
                      initialDate: initialValue,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      initialValue: initialValue,
                      dateFormat: DateFormat('dd MMMM yyyy'),
                      autovalidateMode: AutovalidateMode.always,
                      onDateSelected: (DateTime value) {
                        controller.dateC.text = value.toString();
                      },
                    ),
                  ),
                  SizedBox(height: 17),
                  TitleText(text: "Weight"),
                  SizedBox(height: 7),
                  InputField(
                    keyboardType: TextInputType.number,
                    suffixText: "kilogram",
                    hintText: "Enter weight in kilogram",
                    controller: controller.weightC,
                    validator: controller.validator,
                  ),
                  SizedBox(height: 17),
                  TitleText(text: "Car Number"),
                  SizedBox(height: 7),
                  InputField(
                    hintText: "ex: KB 1678 QU",
                    controller: controller.carC,
                    validator: controller.validator,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  SizedBox(height: 25),
                  StringButton(
                      pressed: () {
                        controller.nameC.text.isEmpty &&
                                controller.priceC.text.isEmpty &&
                                controller.dateC.text.isEmpty &&
                                controller.weightC.text.isEmpty &&
                                controller.carC.text.isEmpty
                            ? controller.textEmpty
                            : controller.updateTxDoc();
                      },
                      text: "Save"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
