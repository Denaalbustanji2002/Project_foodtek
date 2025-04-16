import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helper/responsive.dart';

class section1 {
  // بناء الصورة العلوية
  Widget buildTopImage(BuildContext context, String image) {
    return Positioned(
      top: 0,
      left: 0,
      width: responsiveWidth(context, 430),
      height: responsiveHeight(context, 240),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  // بناء الصورة في المنتصف
  Widget buildCenterImage(BuildContext context, String image) {
    return Positioned(
      top: responsiveHeight(context, 254),
      left: responsiveWidth(context, 50),
      child: SizedBox(
        height: responsiveHeight(context, 219),
        width: responsiveWidth(context, 328.5),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // بناء نص الترحيب
  Widget buildWelcomeText(BuildContext context, String image) {
    return Positioned(
      top: responsiveHeight(context, 518),
      left: responsiveWidth(context, 48),
      width: responsiveWidth(context, 335),
      height: responsiveHeight(context, 158),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(context, 11),
        ),
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // بناء زر "استمرار"
  Widget buildContinueButton(BuildContext context, Function onPressedLogic, String text, double top) {
    return Positioned(
      top: top,
      left: responsiveWidth(context, 62),
      child: SizedBox(
        width: responsiveWidth(context, 307),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF25AE4B), Color(0xFF0F481F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(69),
          ),
          child: ElevatedButton(
            onPressed: () => onPressedLogic(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(69),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                height: 19.36 / 16,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // بناء زر "إلغاء"
  Widget buildCencelButton(BuildContext context, Function onPressedLogic, String text, double top) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cancelColor = isDarkMode ? const Color(0xFF444444) : const Color(0xFFC2C2C2);

    return Positioned(
      top: top,
      left: responsiveWidth(context, 63),
      child: SizedBox(
        width: responsiveWidth(context, 307),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cancelColor,
            borderRadius: BorderRadius.circular(69),
          ),
          child: ElevatedButton(
            onPressed: () => onPressedLogic(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(69),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                height: 19.36 / 16,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
