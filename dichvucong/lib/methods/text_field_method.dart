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

TextField textFieldMethodWithController(
    {String text = "",
    readOnly = false,
    required decoration,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: decoration,
    readOnly: readOnly,
  );
}

Container textFieldContainer(String key, String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: const EdgeInsets.only(bottom: 10), child: Text(key)),
        textFieldMethod(
          readOnly: true,
          text: text,
          decoration: InputDecoration(
              labelText: key,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(100),
                      right: Radius.circular(100)))),
        ),
      ],
    ),
  );
}

Container textFieldContainerWithController(
    {required String key,
    String value = "",
    required TextEditingController controller}) {
  controller.text = value;
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: const EdgeInsets.only(bottom: 10), child: Text(key)),
        textFieldMethodWithController(
          text: value,
          controller: controller,
          decoration: InputDecoration(
              labelText: key,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(100),
                      right: Radius.circular(100)))),
        ),
      ],
    ),
  );
}
