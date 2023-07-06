// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'color.dart';

//HEADER TEXT
class HeaderText extends StatelessWidget {
  HeaderText({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    );
  }
}

//INPUT FIELD
class InputField extends StatelessWidget {
  InputField(
      {super.key,
      this.hintText,
      this.controller,
      this.validator,
      this.onChanged,
      TextCapitalization textCapitalization = TextCapitalization.none});

  final TextEditingController? controller;
  String? Function(String?)? validator;
  TextCapitalization? textCapitalization;
  String? hintText;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.grey2, borderRadius: BorderRadius.circular(7)),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 11)),
        controller: controller,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

//STRING BUTTON
class StringButton extends StatelessWidget {
  StringButton({super.key, required this.pressed, required this.text});

  void Function() pressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: pressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
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
        style: ButtonStyle(backgroundColor: AppColor.abuabu),
        onPressed: () {
          Pressed;
        },
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
        style: ButtonStyle(backgroundColor: AppColor.merah),
        onPressed: Pressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
