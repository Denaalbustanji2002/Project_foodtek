import 'package:flutter/material.dart';
import 'package:foodtek_project/view/widgets/order_done_successfully_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../helper/responsive.dart';
import '../../../theme/app_theme_extensions.dart';
import '../../widgets/notifications_bottom_sheet.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../ordering_screens/cart_history_screen.dart';
import '../ordering_screens/favorites_screen.dart';
import '../ordering_screens/home_screen.dart';
import '../profile_screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDoneSuccessfullyScreen extends StatefulWidget {
  @override
  State<OrderDoneSuccessfullyScreen> createState() =>
      _OrderDoneSuccessfullyScreenState();
}

class _OrderDoneSuccessfullyScreenState
    extends State<OrderDoneSuccessfullyScreen> {


  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<AppThemeExtension>() ?? AppThemeExtension.light;

    return Scaffold(
      backgroundColor: themeExtension.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeExtension.appBarColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: themeExtension.iconColor),
            onPressed: () {
              showNotificationsSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 14)),
              Text(
                AppLocalizations.of(context)!.checkout,
                style: GoogleFonts.inter(
                  color: themeExtension.titleColor,
                  fontSize: responsiveHeight(context, 20),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 20)),

              SizedBox(
                height: responsiveHeight(context, 400),
                width: responsiveWidth(context, 450),
                child: OrderDoneSuccessfullyAnimationWidget(),
              ),
              SizedBox(height: responsiveHeight(context, 20)),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.yourOrderDoneSuccessfully,
                      style: GoogleFonts.inter(
                        fontSize: responsiveWidth(context, 24),
                        fontWeight: FontWeight.w700,
                        color: themeExtension.textColorPrimary,
                        letterSpacing: -0.02,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: responsiveHeight(context, 12)),

                    Text(
                      AppLocalizations.of(context)!.youWillGetYourOrder,
                      style: GoogleFonts.inter(
                        fontSize: responsiveWidth(context, 20),
                        color: themeExtension.secondaryTextColor,
                        letterSpacing: -0.01,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsiveHeight(context, 50)),
              Center(
                child: SizedBox(
                  width: responsiveWidth(context, 327),
                  height: responsiveHeight(context, 58),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryTrackingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeExtension.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(context, 22),
                        vertical: responsiveHeight(context, 18),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.trackYourOrder,
                      style: GoogleFonts.inter(
                        fontSize: responsiveHeight(context, 18),
                        fontWeight: FontWeight.w600,
                        color: themeExtension.buttonTextColor,
                        height: 1.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}
