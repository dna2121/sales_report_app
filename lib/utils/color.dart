import 'package:flutter/material.dart';

class AppColor {
  // static const Color iconColor = Color.fromRGBO(166, 170, 197, 1);
  static const Color iconColor = Colors.amber;
  static const Color body = Color.fromRGBO(22, 30, 93, 1);
  static const Color title = Color.fromRGBO(47, 57, 78, 1);
  static const Color boxShadow = Color.fromRGBO(241, 240, 254, 1);
  static const Color tosca = Color.fromRGBO(85, 184, 179, 1);

 
  static const Color grey =
      const Color.fromRGBO(237, 237, 237, 1); //text, button.
  static const Color background = const Color.fromRGBO(245, 245, 245, 1);

  static MaterialStateProperty<Color?> greyBtn =
      MaterialStateProperty.all<Color>(const Color.fromRGBO(237, 237, 237, 1));

  static MaterialStateProperty<Color?> redBtn =
      MaterialStateProperty.all<Color>(Color.fromRGBO(222, 87, 87, 1));

  static MaterialStateProperty<Color?> putihBtn =
      MaterialStateProperty.all<Color>(Color.fromRGBO(255, 255, 255, 1));

  static MaterialStateProperty<Color?> fabBtn =
      MaterialStateProperty.all<Color>(Color.fromRGBO(102, 85, 184, 1));
}
