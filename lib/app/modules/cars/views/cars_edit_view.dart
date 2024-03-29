import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cars_controller.dart';

class CarsEditView extends GetView<CarsController> {
  const CarsEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String documentId = Get.arguments;
    controller.documentId = documentId;
    controller.fetchCarDoc();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Nomor'),
      ),
      body: Center(
        child: Form(
          key: controller.carsFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Nomor Mobil"),
                  controller: controller.carsController,
                  validator: controller.validator,
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.carsController.text.isEmpty
                        ? controller.textEmpty
                        : controller.updateCarDoc();
                  },
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
