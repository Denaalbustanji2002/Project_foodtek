import 'package:flutter/material.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/turn_on_your_location.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/app_theme_extensions.dart';

class ChooseYourFoodScreen extends StatelessWidget {
  final PageController pageController;

  const ChooseYourFoodScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        color: theme.backgroundColor,
        width: responsiveWidth(context, 430),
        height: responsiveHeight(context, 932),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: -1,
              child: Container(
                width: responsiveWidth(context, 434),
                height: responsiveHeight(context, 254),
                child: Image.asset(
                  "assets/images/splash_screen.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 254),
              left: responsiveWidth(context, 50),
              child: SizedBox(
                height: responsiveHeight(context, 219),
                width: responsiveWidth(context, 328.5),
                child: Image.asset("assets/images/take_away_cuate.png"),
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 518),
              left: responsiveWidth(context, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: responsiveWidth(context, 379),
                    height: responsiveHeight(context, 48),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.chooseFoodTitle,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: responsiveHeight(context, 32),
                        height: 1.0,
                        letterSpacing: 0.0,
                        color: theme.titleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: responsiveWidth(context, 313),
                    height: responsiveHeight(context, 70),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.chooseFoodSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveHeight(context, 16),
                        letterSpacing: -0.01,
                        color: theme.secondaryTextColor,
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
                      theme.primaryColor ?? Color(0xFF25AE4B),
                      Color(0xFF0F481F)
                    ],),
                  borderRadius: BorderRadius.circular(69),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TurnOnYourLocation(),
                      ),
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
                        color: theme.buttonTextColor,
                      ),
                    ),
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
