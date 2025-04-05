import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';

import 'package:google_fonts/google_fonts.dart';


import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';
import 'order_done_successfully_screen.dart';

class AddtoCardScreen extends StatefulWidget {
  @override
  State<AddtoCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddtoCardScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbar2(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: responsiveHeight(context, 26)),
                Text(
                  'Add Card',
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
                  'Name',
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
                  'Card Number',
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
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: responsiveWidth(context, 10)),
                        child: Image.asset(
                          'assets/images/card_icon.png', width: responsiveWidth(context, 20) , height: responsiveHeight(context, 20)


                        ),
                      ),
                    ),
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
                            'Expiry',
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
                            'CVV',
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
                    'We will send you an order details to your\nemail after the successful payment',
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
                      onPressed: ()  {
                        context.read<NavigationCubit>().goTo(ScreenIndex.OrderDoneSuccessfullyScreen);

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
                          Image.asset("assets/images/noun_Lock_1911126.png" , height: 21, width: 16,),
                          SizedBox(width: responsiveWidth(context, 16)),
                          Text(
                            "Pay for the order",
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
      ),
    );
  }
}
