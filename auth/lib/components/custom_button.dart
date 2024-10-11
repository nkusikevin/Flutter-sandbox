import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
