import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ))),
    );
  }
}
