import 'package:flutter/material.dart';

Widget myTextField({
  hintText,
  required controller,
  prefixIcon,
  required bool obscureText,
}) {
  return SizedBox(
    width: 700,
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: prefixIcon,
        filled: true, // Enable background color
        fillColor: Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      ),
    ),
  );
}



