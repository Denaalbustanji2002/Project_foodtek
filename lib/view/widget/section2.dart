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
        required BuildContext context,
        Widget? child,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      width: width,
      height: height,
      top: top,
      left: left,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            if (!isDark)
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
    required BuildContext context,
    required String text,
    bool isOutlined = false,
    Widget? icon,
    VoidCallback? onPressed,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey[700]! : const Color(0xFFEDF1F3);
    final backgroundGradient = isOutlined
        ? null
        : const LinearGradient(
      colors: [Color(0xFF25AE4B), Color(0xFF25AE4B)],
    );

    final textColor = isOutlined
        ? (isDark ? Colors.white : const Color(0xFF1A1D1F))
        : Colors.white;

    return Container(
      width: 295,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: isOutlined
            ? Border.all(color: borderColor, width: 1)
            : null,
        gradient: backgroundGradient,
        color: isOutlined ? Colors.transparent : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon,
                  const SizedBox(width: 10),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
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
