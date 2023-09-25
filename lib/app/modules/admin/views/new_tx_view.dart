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
        title: const Text('Add New Transaction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.trxFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Name"),
                SizedBox(height: 7),
                StreamBuilder(
                    stream: controller.streamName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                InputField(
                  hintText: "Select date",
                  controller: controller.dateC,
                  validator: controller.validator,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await controller.chooseDate();
                  },
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
                StreamBuilder<List<String>>(
                    stream: controller.carNumberStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.grey2,
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownSearch<String>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "Select a car number",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(11)),
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.grey2,
                              borderRadius: BorderRadius.circular(7)),
                          child: DropdownSearch<String>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "Select a car number",
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
                                    hintText: "Search...",
                                    contentPadding: EdgeInsets.all(11)),
                              ),
                            ),
                            items: snapshot.data!,
                            selectedItem: controller.selectedCarnum,
                            // validator: controller.validator,
                            onChanged: (value) async {
                              controller.selectedCarnum = value;
                            },
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(height: 25),
                StringButton(
                    backgroundColor: AppColor.putihBtn,
                    pressed: () {
                      controller.priceC.text.isEmpty &&
                              controller.dateC.text.isEmpty &&
                              controller.weightC.text.isEmpty
                          ? controller.textEmpty
                          : controller.addNewTx();
                    },
                    text: "Save"),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
