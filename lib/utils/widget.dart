// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

//HEADER TEXT
class HeaderText extends StatelessWidget {
  HeaderText({super.key, required this.text, this.color});

  String text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
          color: color),
    );
  }
}

//INPUT FIELD
class InputField extends StatelessWidget {
  InputField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixText,
    this.suffixText,
    this.onTap,
    this.textInputAction,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  void Function(String)? onChanged;
  TextCapitalization textCapitalization;
  final bool readOnly;
  int maxLines;
  TextInputType? keyboardType;
  String? prefixText;
  String? suffixText;
  void Function()? onTap;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.grey, borderRadius: BorderRadius.circular(7)),
      child: TextFormField(
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 11),
            prefixText: prefixText,
            suffixText: suffixText),
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.characters,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onTap: onTap,
        textInputAction: textInputAction,
      ),
    );
  }
}

class TxField extends StatelessWidget {
  TxField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixText,
    this.suffixText,
    this.onTap,
    this.textInputAction,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  void Function(String)? onChanged;
  TextCapitalization textCapitalization;
  final bool readOnly;
  int maxLines;
  TextInputType? keyboardType;
  String? prefixText;
  String? suffixText;
  void Function()? onTap;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.boxShadow, borderRadius: BorderRadius.circular(7)),
      child: TextFormField(
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 11),
            prefixText: prefixText,
            suffixText: suffixText),
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.characters,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onTap: onTap,
        textInputAction: textInputAction,
      ),
    );
  }
}

//REGISTER FIELD
class RegisterField extends StatelessWidget {
  RegisterField(
      {super.key,
      this.hintText,
      this.textEditingController,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      this.maxLines = 1,
      this.inputFormatters});

  String? hintText;
  TextEditingController? textEditingController;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool obscureText;
  TextCapitalization textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.boxShadow,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: AppColor.green),
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.all(16),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: suffixIcon),
        controller: textEditingController,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
      ),
    );
  }
}

//STRING BUTTON
class StringButton extends StatelessWidget {
  StringButton(
      {super.key,
      required this.pressed,
      required this.text,
      this.backgroundColor,
      this.color});

  void Function() pressed;
  String text;
  MaterialStateProperty<Color?>? backgroundColor;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColor.grey,
          //     blurRadius: 18,
          //   ),
          // ],
          ),
      child: ElevatedButton(
        onPressed: pressed,
        style: ButtonStyle(backgroundColor: backgroundColor),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

//EDIT BUTTON
class EditButton extends StatelessWidget {
  EditButton({super.key, required this.text, required this.Pressed});

  void Function() Pressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17, 17, 17, 2),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: AppColor.greyBtn),
        onPressed: Pressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}

//DELETE BUTTON
class DeleteButton extends StatelessWidget {
  DeleteButton({super.key, required this.text, required this.Pressed});

  void Function() Pressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17, 2, 17, 17),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: AppColor.redBtn),
        onPressed: Pressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

//TITLE TEXT
class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

//STRING FIELD
class StringField extends StatelessWidget {
  StringField({
    super.key,
    required this.text,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            color: AppColor.grey, borderRadius: BorderRadius.circular(8)),
        child: TitleText(text: text));
  }
}

BoxDecoration whiteboxDecor() {
  return BoxDecoration(
    color: Color.fromRGBO(112, 103, 229, 1),
    // color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3), // Shadow color
        spreadRadius: 1,
        blurRadius: 70,
        offset: Offset(0, 20),
      ),
    ],
  );
}

BoxDecoration cardboxDecor() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3), // Shadow color
        spreadRadius: 3,
        blurRadius: 8,
        offset: Offset(0, 0),
      ),
    ],
  );
}
