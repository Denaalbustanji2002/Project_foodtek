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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.grey[700]! : const Color(0xFF25AE4B),
        padding: const EdgeInsets.only(
          top: 10,
          right: 24,
          bottom: 10,
          left: 24,
        ),
        minimumSize: const Size(295, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.transparent,
            width: 1,
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
