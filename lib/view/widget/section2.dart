import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section2 {
  Widget getPositionedContainer(
      double width,
      double height,
      double top,
      double left,
      double borderRadius,
      double padding,
      double gap, {
        Widget? child,
      }) {
    return Positioned(
      width: width,
      height: height,
      top: top,
      left: left,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(padding),
        child: child ?? const SizedBox(),
      ),
    );
  }

  Widget customButton({
    required String text,
    bool isOutlined = false,
    Widget? icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: 295, // Width: 295px
      height: 48, // Height: 48px
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Border-radius: 10px
        border: isOutlined
            ? Border.all(color: const Color(0xFFEDF1F3), width: 1) // Border-width: 1px
            : null,
        gradient: isOutlined
            ? null
            : const LinearGradient(
          colors: [Color(0xFF25AE4B), Color(0xFF25AE4B)],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,    // Padding-top: 10px
              right: 24,  // Padding-right: 24px
              bottom: 10, // Padding-bottom: 10px
              left: 24,   // Padding-left: 24px
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon,
                  const SizedBox(width: 10), // Gap: 10px
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: isOutlined ? const Color(0xFF1A1D1F) : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
