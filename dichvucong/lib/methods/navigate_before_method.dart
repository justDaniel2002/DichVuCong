import 'package:flutter/material.dart';

InkWell navigateBeforeMethod(BuildContext context, {color = Colors.black54}) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Icon(
      Icons.navigate_before,
      size: 30,
      color: color,
    ),
  );
}
