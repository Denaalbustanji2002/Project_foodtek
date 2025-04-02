import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/onboarding_screen/page_view_screen.dart';
import '../../../helper/responsive.dart';
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
        MaterialPageRoute(builder: (_) => PageViewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF25AE4B),
      body: Container(
        height: responsiveHeight(context, 932),
        width: responsiveWidth(context, 430),
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
              child: SizedBox(
                width: responsiveWidth(context, 307),
                height: responsiveHeight(context, 85),
                child: Center(
                  child: Text(
                    'Foodtek',
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontFamily: 'ProtestRiot',
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveHeight(context, 80),
                      height: 96 / 80,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
