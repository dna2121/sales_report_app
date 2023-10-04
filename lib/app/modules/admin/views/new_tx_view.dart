import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/controllers/admintx_controller.dart';
import 'package:sales_report_app/utils/color.dart';
import 'package:sales_report_app/utils/widget.dart';

class NewTxView extends GetView<AdminTxController> {
  const NewTxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Baru'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: controller.streamName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading..."));
              }
              if (snapshot.hasData) {
                return Form(
                  key: controller.trxFormKey,
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
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: "Pilih nama",
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
                                      hintText: "Pencarian",
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
                          ),
                          SizedBox(height: 20),
                          TxField(
                            keyboardType: TextInputType.number,
                            prefixText: "Rp. ",
                            hintText: "0",
                            controller: controller.priceC,
                            validator: controller.validator,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 14),
                          Divider(thickness: 0.5),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Berat *",
                                style: TextStyle(
                                    color: Color.fromRGBO(127, 132, 143, 1)),
                              )),
                              Expanded(
                                flex: 3,
                                child: TxField(
                                  keyboardType: TextInputType.number,
                                  suffixText: "kilogram",
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
                                style: TextStyle(
                                    color: Color.fromRGBO(127, 132, 143, 1)),
                              )),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.boxShadow,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: TxField(
                                    controller: controller.dateC,
                                    validator: controller.validator,
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      await controller.chooseDate();
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
                                child: StreamBuilder<List<String>>(
                                    stream: controller.carNumberStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.boxShadow,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: DropdownSearch<String>(
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.all(11)),
                                            ),
                                          ),
                                        );
                                      }

                                      if (snapshot.hasData) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.boxShadow,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: DropdownSearch<String>(
                                            dropdownDecoratorProps:
                                                DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.all(11)),
                                            ),
                                            clearButtonProps: ClearButtonProps(
                                                isVisible: true),
                                            popupProps: PopupProps.dialog(
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                              dialogProps: DialogProps(
                                                backgroundColor:
                                                    AppColor.background,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .symmetric(
                                                            vertical: 11),
                                              ),
                                              searchFieldProps: TextFieldProps(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 17,
                                                    vertical: 12),
                                                decoration: InputDecoration(
                                                    hintText: "Pencarian",
                                                    contentPadding:
                                                        EdgeInsets.all(11)),
                                              ),
                                            ),
                                            items: snapshot.data!,
                                            selectedItem:
                                                controller.selectedCarnum,
                                            // validator: controller.validator,
                                            onChanged: (value) async {
                                              controller.selectedCarnum = value;
                                            },
                                          ),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    }),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                          SizedBox(height: 30),
                          StringButton(
                              color: Colors.white,
                              pressed: () {
                                controller.priceC.text.isEmpty &&
                                        controller.dateC.text.isEmpty &&
                                        controller.weightC.text.isEmpty
                                    ? controller.textEmpty
                                    : controller.addNewTx();
                              },
                              text: "Save"),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
