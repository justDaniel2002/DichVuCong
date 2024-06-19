import 'package:flutter/material.dart';

Container textGreyMethod({required text}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: Text(
      text,
      style: const TextStyle(fontSize: 15, color: Colors.black54),
    ),
  );
}
