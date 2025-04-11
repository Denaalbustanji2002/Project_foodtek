import 'package:flutter/material.dart';
import 'package:foodtek_project/view/screens/checkout_screens/add_card_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/responsive.dart';
import '../../widgets/notifications_bottom_sheet.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../ordering_screens/cart_history_screen.dart';
import '../ordering_screens/favorites_screen.dart';
import '../ordering_screens/home_screen.dart';
import '../profile_screens/profile_screen.dart';

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
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: responsiveHeight(context, 14)),
                Text(
                  "Checkout",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF391713),
                    fontSize: responsiveHeight(context, 20),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 24)),
                Text(
                  'Pay With:',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0A0D13),
                    fontSize: responsiveHeight(context, 18),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    height: 18 / 12,
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 16)),

                Row(
                  children: [
                    Container(
                      width: responsiveWidth(context, 18.35),
                      height: responsiveHeight(context, 20),
                      child: Icon(
                        Icons.share_location,
                        color: Colors.green,
                        size: responsiveHeight(context, 20),
                      ),
                    ),
                    SizedBox(width: responsiveWidth(context, 12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '88 Zurab Gorgiladze St',
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 15),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2F2E36),
                              letterSpacing: 0.15,
                              height: 15 / 12,
                            ),
                          ),
                          Text(
                            'Georgia, Batumi',
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 13),
                              fontWeight: FontWeight.w400,
                              color: Color(0XFFB8B8B8),
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
                        color: Colors.green,
                        size: responsiveHeight(context, 20),
                      ),
                    ),
                    SizedBox(width: responsiveWidth(context, 12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5 Noe Zhordania St',
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 15),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2F2E36),
                              letterSpacing: 0.15,
                              height: 15 / 12,
                            ),
                          ),
                          Text(
                            'Georgia, Batumi',
                            style: TextStyle(
                              fontSize: responsiveHeight(context, 13),
                              fontWeight: FontWeight.w400,
                              color: Color(0XFFB8B8B8),
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
                        'Change',
                        style: GoogleFonts.inter(
                          fontSize: responsiveHeight(context, 14),
                          color: Color(0xFF25AE4B),
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
                  'Promo Code?',
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 16),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0A0D13),
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
                          border: Border.all(color: Color(0XFFD6D6D6)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              responsiveWidth(context, 10),
                            ),
                            bottomLeft: Radius.circular(
                              responsiveWidth(context, 10),
                            ),
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: responsiveWidth(context, 12),
                              vertical: responsiveHeight(context, 16),
                            ),
                            hintText: 'Enter Your Promo',
                            hintStyle: GoogleFonts.inter(
                              color: Color(0XFF878787),
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
                        color: const Color(0xFF34B56F),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                            responsiveWidth(context, 10),
                          ),
                          topRight: Radius.circular(
                            responsiveWidth(context, 10),
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          'Add',
                          style: GoogleFonts.inter(
                            color: Color(0XFFFFFFFF),
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
                  'Pay With:',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0A0D13),
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
                                color:
                                    isCardSelected
                                        ? const Color(0xFF34B56F)
                                        : Colors.grey,
                                width: responsiveWidth(context, 2),
                              ),
                              color: Colors.white,
                            ),
                            child:
                                isCardSelected
                                    ? Center(
                                      child: Container(
                                        width: responsiveWidth(context, 9),
                                        height: responsiveHeight(context, 9),
                                        margin: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF34B56F),
                                        ),
                                      ),
                                    )
                                    : null,
                          ),
                          SizedBox(width: responsiveWidth(context, 8)),
                          Text(
                            'Card',
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 16),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0A0D13),
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
                                color:
                                    isCashSelected
                                        ? const Color(0xFF34B56F)
                                        : Colors.grey,
                                width: responsiveWidth(context, 2),
                              ),
                              color: Colors.white,
                            ),
                            child:
                                isCashSelected
                                    ? Center(
                                      child: Container(
                                        width: responsiveWidth(context, 9),
                                        height: responsiveHeight(context, 9),
                                        margin: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF34B56F),
                                        ),
                                      ),
                                    )
                                    : null,
                          ),
                          SizedBox(width: responsiveWidth(context, 8)),
                          Text(
                            'Cash',
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 16),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0A0D13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsiveHeight(context, 16)),
                Text(
                  'Card Type:',
                  style: GoogleFonts.inter(
                    color: Color(0xFF0A0D13),
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
                                color:
                                    isMastercardSelected
                                        ? Color(0xFF34B56F)
                                        : Colors.grey,
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child:
                                isMastercardSelected
                                    ? Center(
                                      child: Container(
                                        width: responsiveWidth(context, 9),
                                        height: responsiveHeight(context, 9),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF34B56F),
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
                                color:
                                    isVisaSelected
                                        ? Color(0xFF34B56F)
                                        : Colors.grey,
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child:
                                isVisaSelected
                                    ? Center(
                                      child: Container(
                                        width: responsiveWidth(context, 9),
                                        height: responsiveHeight(context, 9),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF34B56F),
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
                    color: const Color(0xFF25AE4B),
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
                              'Sub-Total',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '100 \$',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
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
                              'Delivery Charge',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '10 \$',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
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
                              'Discount',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '10 \$',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
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
                              'Total:',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
                                fontSize: responsiveHeight(context, 18),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.64,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '110\$',
                              style: GoogleFonts.inter(
                                color: Color(0XFFFEFEFF),
                                fontSize: responsiveHeight(context, 18),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.64,
                                height: 1.00,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: responsiveHeight(context, 34)),
                        Container(
                          width: responsiveWidth(context, 366.02),
                          height: responsiveHeight(context, 57),
                          decoration: BoxDecoration(
                            color: Color(0XFFFEFEFF),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCardScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Place My Order',
                              style: GoogleFonts.inter(
                                color: Color(0xFF34B56F),
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
      ),
    );
  }
}
