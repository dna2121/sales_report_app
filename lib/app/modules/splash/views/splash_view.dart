import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          'asset/image/hat.jpg',
          height: 100,
        ),
      )),
    );
  }
}
