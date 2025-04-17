import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/app_theme_extensions.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController pageController;

  const WelcomeScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>();

    return Scaffold(
      body: Container(
        color: appTheme?.scaffoldBackgroundColor ?? Colors.white,
        width: responsiveWidth(context, 430),
        height: responsiveHeight(context, 932),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: -1,
              child: Container(
                width: responsiveWidth(context, 434),
                height: responsiveHeight(context, 251),
                child: Image.asset(
                  "assets/images/splash_screen.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 150),
              left: responsiveWidth(context, 50),
              child: SizedBox(
                height: responsiveHeight(context, 328),
                width: responsiveWidth(context, 328),
                child: Image.asset(
                  "assets/images/order_food_pana.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 518),
              left: responsiveWidth(context, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: responsiveWidth(context, 335),
                    height: responsiveHeight(context, 39),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.welcomeTitle,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: responsiveHeight(context, 32),
                        color: appTheme?.titleColor ?? Color(0xFF455A64),
                        letterSpacing: 0,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 8),
                  Container(
                    width: responsiveWidth(context, 335),
                    height: responsiveHeight(context, 49),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.welcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveHeight(context, 16),
                        height: 1.0,
                        letterSpacing: -0.01,
                        color: appTheme?.secondaryTextColor ?? Color(0xFF455A64),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 712),
              left: responsiveWidth(context, 62),
              child: Container(
                width: responsiveWidth(context, 307),
                height: responsiveHeight(context, 48),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appTheme?.primaryColor ?? Color(0xFF25AE4B),
                      Color(0xFF0F481F)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(69),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme?.shadowColor ?? Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(69),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.continueText,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: appTheme?.buttonTextColor ?? Colors.white,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}
