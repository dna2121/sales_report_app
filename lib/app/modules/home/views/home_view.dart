import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Text(
                  'Hi ${AuthController.instance.firebaseAuth.currentUser!.displayName.toString()}'),
              TextFormField(
                decoration:
                    InputDecoration(labelText: "Enter a new car number"),
                controller: controller.carsController,
                // validator: controller.validator,
              ),
              SizedBox(
                height: 37,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
