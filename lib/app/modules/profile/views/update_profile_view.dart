import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpdateProfileView extends GetView {
  const UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email"),
                      SizedBox(height: 7),
                      Text("Name"),
                      SizedBox(height: 7),
                      Text("Phone Number"),
                      SizedBox(height: 7),
                      Text("Address"),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 7),
            ],
          ),
          Container(
            padding: EdgeInsets.all(17),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
