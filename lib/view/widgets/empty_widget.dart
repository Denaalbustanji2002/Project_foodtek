import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const EmptyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: responsiveHeight(context, 50)),
          Image.asset(
            imagePath,
            width: responsiveWidth(context, 282),
            height: responsiveHeight(context, 282),
          ),
          SizedBox(height: responsiveHeight(context, 51)),
          SizedBox(
            width: responsiveWidth(context, 450),
            height: responsiveHeight(context, 76),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(context, 32),
                fontWeight: FontWeight.w700,
                height: 1.3,
                letterSpacing: -0.02,
                color: const Color(0xFF111827),
              ),
            ),
          ),
          SizedBox(height: responsiveHeight(context, 12)),
          SizedBox(
            width: responsiveWidth(context, 384),
            height: responsiveHeight(context, 22),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(context, 16),
                fontWeight: FontWeight.w500,
                height: 1.4,
                letterSpacing: -0.01,
                color: const Color(0xFF6C7278),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
