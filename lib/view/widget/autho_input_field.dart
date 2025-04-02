import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  final VoidCallback? onTap;
  final bool showSuffixIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  final String? hintText;

  const AuthInputField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.onTap,
    this.showSuffixIcon = false,
    this.suffixIcon,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _AuthInputFieldState createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 295, // Set width to 295
          height: 46, // Set height to 46
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10), // Border-radius of 10px
            border: Border.all(color: const Color(0xFFEDF1F3), width: 1), // Border-width of 1px
          ),
          child: TextFormField(
            controller: widget.controller, // استخدمها مباشرة بدون late
            obscureText: widget.isPassword && !_isPasswordVisible,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            validator: widget.validator,
            keyboardType: widget.keyboardType ?? TextInputType.text, // تأكد من وجود قيمة افتراضية
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), // تم التعديل
              hintText: widget.hintText,
              suffixIcon: widget.showSuffixIcon
                  ? widget.suffixIcon ??
                  IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  )
                  : null,
              prefixIcon: widget.prefixIcon,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
