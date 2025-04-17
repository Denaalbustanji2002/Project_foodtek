import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import '../../../theme/app_theme_extensions.dart';
import '../../widgets/notifications_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isCardSelected = false;
  bool isCashSelected = false;
  bool isMastercardSelected = false;
  bool isVisaSelected = false;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 14)),
              Text(
                AppLocalizations.of(context)!.checkout,
                style: GoogleFonts.inter(
                  color: theme.titleColor,
                  fontSize: responsiveHeight(context, 20),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 24)),
              Text(
                AppLocalizations.of(context)!.payWith,
                style: GoogleFonts.inter(
                  color: theme.textColorPrimary,
                  fontSize: responsiveHeight(context, 18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 18 / 12,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 16)),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: responsiveWidth(context, 18.35),
                    height: responsiveHeight(context, 20),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.share_location,
                      color: theme.primaryColor,
                      size: responsiveHeight(context, 20),
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.zurabGorgiladzeStreet,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 15),
                            fontWeight: FontWeight.w400,
                            color: theme.textColorPrimary,
                            letterSpacing: 0.15,
                            height: 15 / 12,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.georgiaBatumi,
                          style: TextStyle(
                            fontSize: responsiveHeight(context, 13),
                            fontWeight: FontWeight.w400,
                            color: theme.secondaryTextColor,
                            letterSpacing: 0.15,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: responsiveWidth(context, 18.35),
                    height: responsiveHeight(context, 20),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: theme.primaryColor,
                      size: responsiveHeight(context, 20),
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.noeZhordaniaStreet,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 15),
                            fontWeight: FontWeight.w400,
                            color: theme.textColorPrimary,
                            letterSpacing: 0.15,
                            height: 15 / 12,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.georgiaBatumi,
                          style: TextStyle(
                            fontSize: responsiveHeight(context, 13),
                            fontWeight: FontWeight.w400,
                            color: theme.secondaryTextColor,
                            letterSpacing: 0.15,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.change,
                      style: GoogleFonts.inter(
                        fontSize: responsiveHeight(context, 14),
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 27)),
              Text(
                AppLocalizations.of(context)!.promoCode,
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 16),
                  fontWeight: FontWeight.w600,
                  color: theme.textColorPrimary,
                  letterSpacing: 0.0,
                  height: 16 / 17,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 12)),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: responsiveWidth(context, 376),
                      height: responsiveHeight(context, 42),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.borderColor),
                        borderRadius: Directionality.of(context) == TextDirection.rtl
                            ? BorderRadius.only(
                          topRight: Radius.circular(responsiveWidth(context, 10)),
                          bottomRight: Radius.circular(responsiveWidth(context, 10)),
                        )
                            : BorderRadius.only(
                          topLeft: Radius.circular(responsiveWidth(context, 10)),
                          bottomLeft: Radius.circular(responsiveWidth(context, 10)),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: responsiveWidth(context, 12),
                            vertical: responsiveHeight(context, 16),
                          ),
                          hintText: AppLocalizations.of(context)!.enterYourPromo,
                          hintStyle: GoogleFonts.inter(
                            color: theme.hintTextColor,
                            fontSize: responsiveHeight(context, 12),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.0,
                            height: 1.5,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                  Container(
                    height: responsiveHeight(context, 42),
                    width: responsiveWidth(context, 90),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: Directionality.of(context) == TextDirection.rtl
                          ? BorderRadius.only(
                        topLeft: Radius.circular(responsiveWidth(context, 10)),
                        bottomLeft: Radius.circular(responsiveWidth(context, 10)),
                      )
                          : BorderRadius.only(
                        topRight: Radius.circular(responsiveWidth(context, 10)),
                        bottomRight: Radius.circular(responsiveWidth(context, 10)),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: GoogleFonts.inter(
                          color: theme.buttonTextColor,
                          fontSize: responsiveHeight(context, 12),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 24)),
              Text(
                AppLocalizations.of(context)!.payWith,
                style: GoogleFonts.inter(
                  color: theme.textColorPrimary,
                  fontSize: responsiveHeight(context, 18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 18 / 12,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 16)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCardSelected = true;
                        isCashSelected = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 15),
                          height: responsiveHeight(context, 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isCardSelected ? theme.primaryColor : theme.secondaryTextColor,
                              width: responsiveWidth(context, 2),
                            ),
                            color: theme.backgroundColor,
                          ),
                          child: isCardSelected
                              ? Center(
                            child: Container(
                              width: responsiveWidth(context, 9),
                              height: responsiveHeight(context, 9),
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                              : null,
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Text(
                          AppLocalizations.of(context)!.card,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 16),
                            fontWeight: FontWeight.w500,
                            color: theme.textColorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 36)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCardSelected = false;
                        isCashSelected = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 15),
                          height: responsiveHeight(context, 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isCashSelected ? theme.primaryColor : theme.secondaryTextColor,
                              width: responsiveWidth(context, 2),
                            ),
                            color: theme.backgroundColor,
                          ),
                          child: isCashSelected
                              ? Center(
                            child: Container(
                              width: responsiveWidth(context, 9),
                              height: responsiveHeight(context, 9),
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                              : null,
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Text(
                          AppLocalizations.of(context)!.cash,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 16),
                            fontWeight: FontWeight.w500,
                            color: theme.textColorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 16)),
              Text(
                AppLocalizations.of(context)!.cardType,
                style: GoogleFonts.inter(
                  color: theme.textColorPrimary,
                  fontSize: responsiveHeight(context, 18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 18 / 12,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 16)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMastercardSelected = true;
                        isVisaSelected = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 15),
                          height: responsiveHeight(context, 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isMastercardSelected ? theme.primaryColor : theme.secondaryTextColor,
                              width: 2,
                            ),
                            color: theme.backgroundColor,
                          ),
                          child: isMastercardSelected
                              ? Center(
                            child: Container(
                              width: responsiveWidth(context, 9),
                              height: responsiveHeight(context, 9),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                              : null,
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Container(
                          width: responsiveWidth(context, 26.27),
                          height: responsiveHeight(context, 17),
                          child: Image.asset(
                            'assets/icons/Mastercard.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: responsiveWidth(context, 36)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMastercardSelected = false;
                        isVisaSelected = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 15),
                          height: responsiveHeight(context, 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isVisaSelected ? theme.primaryColor : theme.secondaryTextColor,
                              width: 2,
                            ),
                            color: theme.backgroundColor,
                          ),
                          child: isVisaSelected
                              ? Center(
                            child: Container(
                              width: responsiveWidth(context, 9),
                              height: responsiveHeight(context, 9),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                              : null,
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Container(
                          width: responsiveWidth(context, 26.27),
                          height: responsiveHeight(context, 17),
                          child: Image.asset(
                            'assets/icons/Visa.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsiveHeight(context, 32)),

              Container(
                height: responsiveHeight(context, 206),
                width: responsiveWidth(context, 378),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.subTotal,
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                          Text(
                            '100 \$',
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsiveHeight(context, 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.deliveryCharge,
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                          Text(
                            '10 \$',
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsiveHeight(context, 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.discount,
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                          Text(
                            '10 \$',
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: responsiveHeight(context, 14),
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsiveHeight(context, 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.total,
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontSize: responsiveHeight(context, 18),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.64,
                              height: 1.00,
                            ),
                          ),
                          Text(
                            '110\$',
                            style: GoogleFonts.inter(
                              color: theme.buttonTextColor,
                              fontSize: responsiveHeight(context, 18),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.64,
                              height: 1.00,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsiveHeight(context, 29)),
                      Container(
                        width: responsiveWidth(context, 366.02),
                        height: responsiveHeight(context, 57),
                        decoration: BoxDecoration(
                          color: theme.containerColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/addCard');
                          },
                          child: Text(
                            AppLocalizations.of(context)!.placeMyOrder,
                            style: GoogleFonts.inter(
                              color: theme.primaryColor,
                              fontSize: responsiveHeight(context, 14),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              height: 1.00,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}
