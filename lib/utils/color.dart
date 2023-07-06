import 'package:flutter/material.dart';

class AppColor {
  static const Color green = const Color.fromRGBO(136, 164, 124, 1);
  static const Color grey = const Color.fromRGBO(239, 239, 239, 1); //navbar
  static const Color grey2 =
      const Color.fromRGBO(237, 237, 237, 1); //text, button.

  static MaterialStateProperty<Color?> hijau =
      MaterialStateProperty.all<Color>(const Color.fromRGBO(136, 164, 124, 1));

  static MaterialStateProperty<Color?> abuabu =
      MaterialStateProperty.all<Color>(const Color.fromRGBO(237, 237, 237, 1));

  static MaterialStateProperty<Color?> merah =
      MaterialStateProperty.all<Color>(Color.fromRGBO(222, 87, 87, 1));
}
