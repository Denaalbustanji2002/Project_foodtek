import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/view/screens/authentication_screens/login_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/location_cubit.dart';
import '../../../cubits/theme_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/location_state.dart';
import '../../../theme/app_theme_extensions.dart';
import '../../widgets/permission_denid_forever_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TurnOnYourLocation extends StatelessWidget {
  const TurnOnYourLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationPermissionGranted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is LocationPermissionDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.locationPermissionDenied,
                  style: TextStyle(color: theme.textColorPrimary),
                ),
                backgroundColor: theme.containerColor,
              ),
            );
          } else if (state is LocationPermissionDeniedForever) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: theme.containerColor,
                  title: Text(
                    AppLocalizations.of(context)!
                        .oopsPermissionDeniedForeverPleaseAllowLocationPermissionFromSettings,
                    style: TextStyle(
                      color: theme.spicyRedColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: PermissionDenidForeverWidget(),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is LocationServiceDisabled) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: theme.containerColor,
                title: Text(
                  AppLocalizations.of(context)!.locationServiceDisabled,
                  style: TextStyle(color: theme.titleColor),
                ),
                content: Text(
                  AppLocalizations.of(context)!
                      .pleaseEnableLocationServicesToContinue,
                  style: TextStyle(color: theme.secondaryTextColor),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Geolocator.openLocationSettings();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.openSettings,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        color: theme.disabledColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        child: Stack(
          children: [
            buildMapImage(context),
            buildCenterImage(context),
            buildTurnOnYourLocationText(context),
            buildYesTurnItOnButton(context),
            buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildMapImage(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMode;
    // 2. اختار الباث حسب الحالة
    final imagePath = isDark
        ? "assets/images/dark_map.jpg"
        : "assets/images/light_map.png";

    return Positioned(
      top: 0,
      left: 0,
      width: responsiveWidth(context, 430),
      height: responsiveHeight(context, 254),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }


  Widget buildCenterImage(BuildContext context) {
    return Positioned(
      top: responsiveHeight(context, 254),
      left: responsiveWidth(context, 50),
      child: SizedBox(
        height: responsiveHeight(context, 219),
        width: responsiveWidth(context, 328.5),
        child: Image.asset(
          "assets/images/take_away_cuate.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTurnOnYourLocationText(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Positioned(
      top: responsiveHeight(context, 518),
      left: responsiveWidth(context, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.locationTitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: responsiveHeight(context, 32),
                color: theme.titleColor, // تم التعديل هون
                letterSpacing: 0,
                height: 1.0,
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
              AppLocalizations.of(context)!.locationSubtitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: responsiveHeight(context, 16),
                color: theme.secondaryTextColor, // وتم التعديل هون
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildYesTurnItOnButton(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Positioned(
      top: responsiveHeight(context, 668),
      left: responsiveWidth(context, 62),
      child: SizedBox(
        width: responsiveWidth(context, 307),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                theme.primaryColor.withOpacity(0.7), // أو حط لون ثاني حسب الثيم
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(69),
          ),
          child: ElevatedButton(
            onPressed: () {
              context.read<LocationCubit>().checkLocationPermission(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(69),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: theme.buttonTextColor,
              elevation: 0,
            ),
            child: Text(
              AppLocalizations.of(context)!.yesTurnItOn,
              style: TextStyle(
                color: theme.buttonTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return Positioned(
      top: responsiveHeight(context, 728),
      left: responsiveWidth(context, 63),
      child: SizedBox(
        width: responsiveWidth(context, 307),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFC2C2C2),
            borderRadius: BorderRadius.circular(69),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(69),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                height: 19.36 / 16,
                letterSpacing: 0,
                color: Color(0XFF455A64),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
