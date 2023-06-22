import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
              StreamBuilder(
                  stream: controller.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (snapshot.hasData) {
                      var userData = snapshot.data!;

                      return Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userData['email']),
                              SizedBox(height: 7),
                              Text(userData['name']),
                              SizedBox(height: 7),
                              Text(userData['phoneNumber']),
                              SizedBox(height: 7),
                              Text(userData['address']),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox();
                    } else {
                      return SizedBox();
                    }
                  })
            ],
          ),
          Container(
            padding: EdgeInsets.all(17),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Edit Profile"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              // style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color?>(
              //         Color.fromARGB(255, 255, 71, 58))),
              child: Text("Log out"),
            ),
          ),
        ],
      ),
    );
  }
}
