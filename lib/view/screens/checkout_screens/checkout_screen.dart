import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';

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

  // Helper function for responsive width
  double responsiveWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * (width / 414);
  }

  // Helper function for responsive height
  double responsiveHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * (height / 896);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbar2(),
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
                SizedBox(height: responsiveHeight(context, 14)),
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
                SizedBox(height: responsiveHeight(context, 10)),

                Row(
                  children: [
                    Container(
                      width: responsiveWidth(context, 18.35),
                      height: responsiveHeight(context, 20),
                      child: const Icon(
                        Icons.share_location,
                        color: Colors.green,
                        size: 20,
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
                              color: const Color(0XFFB8B8B8),
                              letterSpacing: 0.15,
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: responsiveWidth(context, 18.35),
                      height: responsiveHeight(context, 20),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                        size: 20,
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
                              color: const Color(0XFFB8B8B8),
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
                          color: const Color(0xFF25AE4B),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsiveHeight(context, 25)),
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
                SizedBox(height: responsiveHeight(context, 10)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: responsiveHeight(context, 42),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFFD6D6D6)),
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
                              color: const Color(0XFF878787),
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
                        onPressed: () {},
                        child: Text(
                          'Add',
                          style: GoogleFonts.inter(
                            color: const Color(0XFFFFFFFF),
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
                SizedBox(height: responsiveHeight(context, 12)),
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
                                color: isCardSelected
                                    ? const Color(0xFF34B56F)
                                    : Colors.grey,
                                width: responsiveWidth(context, 2),
                              ),
                              color: Colors.white,
                            ),
                            child: isCardSelected
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
                                color: isCashSelected
                                    ? const Color(0xFF34B56F)
                                    : Colors.grey,
                                width: responsiveWidth(context, 2),
                              ),
                              color: Colors.white,
                            ),
                            child: isCashSelected
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
                SizedBox(height: responsiveHeight(context, 12)),
                Text(
                  'Card Type:',
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
                                color: isMastercardSelected
                                    ? const Color(0xFF34B56F)
                                    : Colors.grey,
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child: isMastercardSelected
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
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
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
                                color: isVisaSelected
                                    ? const Color(0xFF34B56F)
                                    : Colors.grey,
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child: isVisaSelected
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
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsiveHeight(context, 30)),

                Container(
                  height: responsiveHeight(context, 206),
                  width: double.infinity,
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
                                color: const Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '100 \$',
                              style: GoogleFonts.inter(
                                color: const Color(0XFFFEFEFF),
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
                                color: const Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '10 \$',
                              style: GoogleFonts.inter(
                                color: const Color(0XFFFEFEFF),
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
                                color: const Color(0XFFFEFEFF),
                                fontWeight: FontWeight.w400,
                                fontSize: responsiveHeight(context, 14),
                                letterSpacing: 0.5,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '10 \$',
                              style: GoogleFonts.inter(
                                color: const Color(0XFFFEFEFF),
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
                                color: const Color(0XFFFEFEFF),
                                fontSize: responsiveHeight(context, 18),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.64,
                                height: 1.00,
                              ),
                            ),
                            Text(
                              '110\$',
                              style: GoogleFonts.inter(
                                color: const Color(0XFFFEFEFF),
                                fontSize: responsiveHeight(context, 18),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.64,
                                height: 1.00,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: responsiveHeight(context, 34)),
                        SizedBox(
                          width: double.infinity,
                          height: responsiveHeight(context, 57),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFFFEFEFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            onPressed: () {
                              context.read<NavigationCubit>().goTo(ScreenIndex.AddtoCardScreen);
                            },
                            child: Text(
                              'Place My Order',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF34B56F),
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

// Placeholder for AddCardScreen - you should replace this with your actual implementation
class AddCardScreen extends StatelessWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Card'),
      ),
      body: const Center(
        child: Text('Add Card Screen'),
      ),
    );
  }
}