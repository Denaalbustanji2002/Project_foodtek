import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/view/screens/authentication_screens/login_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/location_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/location_state.dart';
import '../../widgets/permission_denid_forever_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TurnOnYourLocation extends StatelessWidget {
  const TurnOnYourLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationPermissionGranted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is LocationPermissionDenied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.locationPermissionDenied,)),
            );
          } else if (state is LocationPermissionDeniedForever) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.oopsPermissionDeniedForeverPleaseAllowLocationPermissionFromSettings,
                    style: TextStyle(
                      color: Colors.red,
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
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is LocationServiceDisabled) {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.locationServiceDisabled),
                    content: Text(
                      AppLocalizations.of(context)!.pleaseEnableLocationServicesToContinue,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Geolocator.openLocationSettings();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.openSettings,
                          style: TextStyle(
                            color: Colors.blue,
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
                          style: TextStyle(color: Colors.grey, fontSize: 16),
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
    return Positioned(
      top: 0,
      left: 0,
      width: responsiveWidth(context, 430),
      height: responsiveHeight(context, 254),
      child: Image.asset("assets/images/maps.png", fit: BoxFit.cover),
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
                color: Color(0xFF455A64),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child:  Text(
              AppLocalizations.of(context)!.locationSubtitle,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: responsiveHeight(context, 16),
                color: Color(0xFF455A64),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildYesTurnItOnButton(BuildContext context) {
    return Positioned(
      top: responsiveHeight(context, 668),
      left: responsiveWidth(context, 62),
      child: SizedBox(
        width: responsiveWidth(context, 307),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF25AE4B), Color(0xFF0F481F)],
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
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              AppLocalizations.of(context)!.yesTurnOn,
              style: TextStyle(
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
