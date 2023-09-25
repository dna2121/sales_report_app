import 'package:flutter/material.dart';

class AppColor {
  static const Color iconColor = Color.fromRGBO(166, 170, 197, 1);
  static const Color body = Color.fromRGBO(22, 30, 93, 1);
  static const Color title = Color.fromRGBO(47, 57, 78, 1);
  static const Color boxShadow = Color.fromRGBO(241, 240, 254, 1);

  static const Color adminBody = Color.fromRGBO(22, 93, 45, 1);
  static const Color adminBoxShadow = Color.fromARGB(255, 236, 255, 242);

  static const Color green = const Color.fromRGBO(136, 164, 124, 1);
  static const Color grey = const Color.fromRGBO(239, 239, 239, 1); //navbar
  static const Color grey2 =
      const Color.fromRGBO(237, 237, 237, 1); //text, button.
  static const Color background = const Color.fromRGBO(245, 245, 245, 1);

  static MaterialStateProperty<Color?> button =
      MaterialStateProperty.all<Color>(const Color.fromRGBO(240, 241, 253, 1));

  static MaterialStateProperty<Color?> abuabu =
      MaterialStateProperty.all<Color>(const Color.fromRGBO(237, 237, 237, 1));

  static MaterialStateProperty<Color?> merah =
      MaterialStateProperty.all<Color>(Color.fromRGBO(222, 87, 87, 1));

  static MaterialStateProperty<Color?> putihBtn =
      MaterialStateProperty.all<Color>(Color.fromRGBO(255, 255, 255, 1));
}
