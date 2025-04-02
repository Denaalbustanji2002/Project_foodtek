import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF25AE4B),
        padding: const EdgeInsets.only(
          top: 10,    // Padding-top: 10px
          right: 24,  // Padding-right: 24px
          bottom: 10, // Padding-bottom: 10px
          left: 24,   // Padding-left: 24px
        ),
        minimumSize: const Size(295, 48), // Width: 295, Height: 48
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border-radius: 10px
          side: const BorderSide(
            color: Colors.transparent, // No visible border color by default
            width: 1,                  // Border-width: 1px
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
