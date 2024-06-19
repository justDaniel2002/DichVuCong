import 'package:flutter/material.dart';

TextField textFieldMethod(
    {String text = "", readOnly = false, required decoration}) {
  final TextEditingController controller = TextEditingController();
  controller.text = text;
  return TextField(
    controller: controller,
    decoration: decoration,
    readOnly: readOnly,
  );
}
