import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme_extensions.dart';
import '../../widgets/notifications_bottom_sheet.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../ordering_screens/cart_history_screen.dart';
import '../ordering_screens/favorites_screen.dart';
import '../ordering_screens/home_screen.dart';
import '../profile_screens/profile_screen.dart';
import 'order_done_successfully_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController nameTextEditingController =
      TextEditingController();

  final TextEditingController cardNumberTextEditingController =
      TextEditingController();

  final TextEditingController expiryTextEditingController =
      TextEditingController();

  final TextEditingController cvvTextEditingController =
      TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>() ?? AppThemeExtension.light;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: theme.iconColor),
            onPressed: () {
              showNotificationsSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 26)),
              Text(
                AppLocalizations.of(context)!.addCard,
                style: GoogleFonts.inter(
                  color: theme.titleColor,
                  fontSize: responsiveHeight(context, 20),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 24)),
              Image.asset('assets/images/addcard.png'),

              SizedBox(height: responsiveHeight(context, 16)),

              Text(
                AppLocalizations.of(context)!.name,
                style: GoogleFonts.plusJakartaSans(
                  color: theme.labelTextColor,
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.02,
                  height: 1.6,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 2)),
              Container(
                width: responsiveWidth(context, 368),
                height: responsiveHeight(context, 46),
                decoration: BoxDecoration(
                  color: theme.containerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: nameTextEditingController,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: theme.textFieldTextColor,
                    height: 1.4,
                    letterSpacing: -0.01,
                  ),
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveHeight(context, 14),
                      color: theme.hintTextColor,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(context, 13),
                      vertical: responsiveHeight(context, 14),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: responsiveHeight(context, 16)),

              Text(
                AppLocalizations.of(context)!.cardNumber,
                style: GoogleFonts.plusJakartaSans(
                  color: theme.labelTextColor,
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.02,
                  height: 1.6,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 2)),
              Container(
                width: responsiveWidth(context, 368),
                height: responsiveHeight(context, 46),
                decoration: BoxDecoration(
                  color: theme.containerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.borderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: cardNumberTextEditingController,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: theme.textFieldTextColor,
                          height: 1.4,
                          letterSpacing: -0.01,
                        ),
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: responsiveHeight(context, 14),
                            color: theme.hintTextColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: responsiveWidth(context, 13),
                            vertical: responsiveHeight(context, 14),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: responsiveWidth(context, 38),
                        height: responsiveHeight(context, 38),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/card_icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: responsiveHeight(context, 16)),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.expiry,
                          style: GoogleFonts.plusJakartaSans(
                            color: theme.labelTextColor,
                            fontSize: responsiveHeight(context, 12),
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 2)),
                        Container(
                          width: responsiveWidth(context, 176),
                          height: responsiveHeight(context, 46),
                          decoration: BoxDecoration(
                            color: theme.containerColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme.borderColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.shadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: cardNumberTextEditingController,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: theme.textFieldTextColor,
                              height: 1.4,
                              letterSpacing: -0.01,
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                color: theme.hintTextColor,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: responsiveWidth(context, 13),
                                vertical: responsiveHeight(context, 14),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 7)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.cvc,
                          style: GoogleFonts.plusJakartaSans(
                            color: theme.labelTextColor,
                            fontSize: responsiveHeight(context, 12),
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.02,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 2)),
                        Container(
                          width: responsiveWidth(context, 176),
                          height: responsiveHeight(context, 46),
                          decoration: BoxDecoration(
                            color: theme.containerColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme.borderColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.shadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: cardNumberTextEditingController,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: theme.textFieldTextColor,
                              height: 1.4,
                              letterSpacing: -0.01,
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                color: theme.hintTextColor,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: responsiveWidth(context, 13),
                                vertical: responsiveHeight(context, 14),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 16)),

              Container(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.weWillSendYou,
                  style: GoogleFonts.inter(
                    color: theme.secondaryTextColor,
                    fontSize: responsiveHeight(context, 12),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.02,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),

              SizedBox(height: responsiveHeight(context, 16)),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: responsiveWidth(context, 327),
                  height: responsiveHeight(context, 57),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/orderDone');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(context, 22),
                        vertical: responsiveHeight(context, 18),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icons/lock.png"),
                        SizedBox(width: responsiveWidth(context, 16)),
                        Text(
                          AppLocalizations.of(context)!.payForTheOrder,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 18),
                            fontWeight: FontWeight.w600,
                            color: theme.buttonTextColor,
                            height: 1.0,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
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
