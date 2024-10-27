import 'package:flutter/material.dart';

Widget buttonCustom(String buttonLabel, VoidCallback? buttonOnTap) {
  return TextButton(
    onPressed: buttonOnTap,
    style: TextButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
    ),
    child: Text(buttonLabel, style: const TextStyle(color: Colors.white)),
  );
}