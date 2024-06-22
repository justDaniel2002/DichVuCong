import 'package:flutter/material.dart';

SizedBox buttonMethod(
    {backgroundColor = Colors.blue,
    foregroundColor = Colors.white,
    required displayText,
    required onPressed,
    double width = double.infinity}) {
  return SizedBox(
    width: width,
    height: 45,
    child: ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Background color
        foregroundColor: foregroundColor, // Text color
      ),
      child: Text(
        displayText,
        style: const TextStyle(fontSize: 20),
      ),
    ),
  );
}
