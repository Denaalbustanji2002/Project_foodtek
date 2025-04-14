import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
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
                  color: const Color(0xFF391713),
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
                  color: Color(0XFF6C7278),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFEDF1F3),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3DE4E5E7),
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
                    color: Color(0XFF1A1C1E),
                    height: 1.4,
                    letterSpacing: -0.01,
                  ),
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: responsiveHeight(context, 14),
                      color: Colors.grey[500],
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
                  color: Color(0XFF6C7278),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFEDF1F3),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3DE4E5E7),
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
                          color: Color(0XFF1A1C1E),
                          height: 1.4,
                          letterSpacing: -0.01,
                        ),
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: responsiveHeight(context, 14),
                            color: Colors.grey[500],
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
                            color: Color(0XFF6C7278),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFEDF1F3),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3DE4E5E7),
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
                              color: Color(0XFF1A1C1E),
                              height: 1.4,
                              letterSpacing: -0.01,
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                color: Colors.grey[500],
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
                            color: Color(0XFF6C7278),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFEDF1F3),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3DE4E5E7),
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
                              color: Color(0XFF1A1C1E),
                              height: 1.4,
                              letterSpacing: -0.01,
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                color: Colors.grey[500],
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
                    color: Color(0XFF929DA9),
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
                      backgroundColor: const Color(0xFF25AE4B),
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
                            color: Colors.white,
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
  }
}
