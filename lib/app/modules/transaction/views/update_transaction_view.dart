import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/modules/transaction/controllers/admin_transaction_controller.dart';

import '../../../../utils/color.dart';
import '../../../../utils/widget.dart';

class UpdateTransactionView extends GetView<AdminTransactionController> {
  const UpdateTransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchTxDoc();
    DateTime initialValue =
        DateTime.tryParse(controller.dateC.text) ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Transaksi'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(19, 50, 19, 50),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey.shade300, // Border color
                width: 1, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Shadow color
                  spreadRadius: 1,
                  blurRadius: 70,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.boxShadow,
                      borderRadius: BorderRadius.circular(8)),
                  child: StreamBuilder(
                      stream: controller.streamName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        }

                        if (snapshot.hasData) {
                          return DropdownSearch<String>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "Nama",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(11)),
                            ),
                            clearButtonProps: ClearButtonProps(isVisible: true),
                            popupProps: PopupProps.dialog(
                              showSearchBox: true,
                              showSelectedItems: true,
                              dialogProps: DialogProps(
                                backgroundColor: AppColor.background,
                                contentPadding: EdgeInsetsDirectional.symmetric(
                                    vertical: 11),
                              ),
                              searchFieldProps: TextFieldProps(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 12),
                                decoration: InputDecoration(
                                    hintText: "Pencarian",
                                    contentPadding: EdgeInsets.all(11)),
                              ),
                            ),
                            items: snapshot.data!,
                            selectedItem: controller.selectedName,
                            validator: controller.validator,
                            onChanged: (value) async {
                              controller.selectedName = value;
                              // String? userId =
                              //     await controller.getUserIdFromName(value!);

                              // controller.carNumberStream =
                              //     controller.streamCarNumber(userId!);
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
                SizedBox(height: 20),
                TxField(
                  keyboardType: TextInputType.number,
                  prefixText: "Rp. ",
                  hintText: "0",
                  controller: controller.priceC,
                  validator: controller.validator,
                ),
                SizedBox(height: 14),
                Divider(thickness: 0.5),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Berat *",
                      style: TextStyle(color: Color.fromRGBO(127, 132, 143, 1)),
                    )),
                    Expanded(
                      flex: 3,
                      child: TxField(
                        keyboardType: TextInputType.number,
                        suffixText: "kg",
                        hintText: "kilogram",
                        controller: controller.weightC,
                        validator: controller.validator,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Tanggal *",
                      style: TextStyle(color: Color.fromRGBO(127, 132, 143, 1)),
                    )),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.boxShadow,
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
                          dateFormat: DateFormat('dd MMM yyyy'),
                          autovalidateMode: AutovalidateMode.always,
                          onDateSelected: (DateTime value) {
                            controller.dateC.text = value.toString();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Nomor Kendaraan",
                      style: TextStyle(
                          color: Color.fromRGBO(127, 132, 143, 1),
                          fontSize: 13),
                    )),
                    Expanded(
                      flex: 3,
                      child: TxField(
                        hintText: "ex: KB 1678 QU",
                        controller: controller.carC,
                        validator: controller.validator,
                        textCapitalization: TextCapitalization.characters,
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
                SizedBox(height: 30),
                StringButton(
                    color: Colors.white,
                    pressed: () {
                      controller.selectedName!.isEmpty ||
                              controller.priceC.text.isEmpty ||
                              controller.dateC.text.isEmpty ||
                              controller.weightC.text.isEmpty ||
                              controller.carC.text.isEmpty
                          ? controller.textEmptyUpdate
                          : controller.updateTxDoc();
                    },
                    text: "Simpan"),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
