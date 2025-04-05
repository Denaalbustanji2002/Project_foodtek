import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? label;
  final bool obscureText;
  final String? errorText;
  final String? hintText;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? obscuringCharacter;
  final int? errorMaxLines;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool isPassword;
  final bool showPasswordToggle;
  final VoidCallback? onPasswordToggle;

  InputWidget({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    this.prefixIcon,
    this.label,
    this.suffixIcon,
    this.maxLines,
    this.keyboardType,
    this.hintText,
    this.errorText,
    this.obscuringCharacter,
    this.errorMaxLines,
    this.textStyle,
    this.onTap,
    this.onChanged,
    this.isPassword = false,
    this.showPasswordToggle = false,
    this.onPasswordToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label!,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0XFF6C7278),
              letterSpacing: -0.02,
              height: 1.6,
            ),
          ),
        if (label != null) SizedBox(height: 4),
        SizedBox(
          height: 46,
          child: TextField(
            controller: textEditingController,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter ?? '*',
            keyboardType: keyboardType,
            maxLines: maxLines ?? 1,
            style: textStyle ?? GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0XFF1A1C1E),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0XFF1A1C1E),
              ),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: showPasswordToggle
                  ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: onPasswordToggle,
              )
                  : suffixIcon,
            ),
            onTap: onTap,
            onChanged: onChanged,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ),
      ],
    );
  }
}