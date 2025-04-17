import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/page_view_screen.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/responsive.dart';
import '../../../theme/app_theme_extensions.dart';
import '../authentication_screens/language_screen.dart';
import '../authentication_screens/send_reset_link_forgot_password_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>PageViewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Scaffold(
      backgroundColor:theme.splashScreenColor,
      body: Container(
        width: responsiveWidth(context, 430),
        height: responsiveHeight(context, 932),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: responsiveHeight(context, 415),
              left: responsiveWidth(context, 71),
              child: Text(
                'Foodtek',
                style: GoogleFonts.protestRiot(
                  fontSize: 80,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.0,
                  letterSpacing: 0.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
