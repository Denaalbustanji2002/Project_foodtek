import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';
import '../add_to_cart/screen/history_screen.dart';
import '../home_cart/screen/favorites_screen.dart';
import '../home_cart/screen/home_screen.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../profile_screens/profile_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF391713),
          iconSize: responsiveHeight(context, 20),
          onPressed: () {
            context.read<NavigationCubit>().pop();
          },
        ),
      ),
      title: Text(
        'Order Details',
        style: GoogleFonts.inter(
          fontSize: responsiveHeight(context, 20),
          fontWeight: FontWeight.w600,
          color: Color(0xFF391713),
        ),
      ),
      leadingWidth: responsiveWidth(context, 25),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderInfo(),
          SizedBox(height: 20),
          _buildTrackingSteps(),
          SizedBox(height: 20),
          _buildDeliveryHeroCard(context),
          SizedBox(height: 20),
          _buildLocationDetails(context),
          SizedBox(height: 100),
          _buildLiveTrackButton(context),
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Row(
      children: [
        _buildIconContainer("assets/images/takeaway_photo.png"),
        SizedBox(width: 10),
        _buildOrderDetails(),
      ],
    );
  }

  Widget _buildIconContainer(String assetPath) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Image.asset(assetPath, fit: BoxFit.contain)),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order ID',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF391713),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            '#6579-6432',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Color(0xFF878787),
              fontWeight: FontWeight.w500,
              height: 1.0,
              letterSpacing: 0.0,
            ),
          ),
        ),
        Text(
          '25m',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Color(0xFF263238),
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: -0.01,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrackingStep('Order received', Icons.check_rounded, true, false),
        _buildTrackingStep(
          'Cooking your order',
          Icons.kitchen_outlined,
          true,
          false,
        ),
        _buildTrackingStep(
          'Courier is picking up order',
          Icons.person,
          true,
          false,
        ),
        _buildTrackingStep('Order delivered', Icons.home, false, true),
      ],
    );
  }

  Widget _buildTrackingStep(
    String text,
    IconData icon,
    bool isCompleted,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 39.7,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? Color(0xFF25AE4B) : Color(0xFFF7F7F7),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.black54,
                size: 24,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 20,
                color: isCompleted ? Color(0xFF25AE4B) : Color(0xFFF7F7F7),
              ),
          ],
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: isCompleted ? Color(0xFF1C1B1F) : Color(0xFF1C1B1F),
            fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryHeroCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/photo.png'),
            radius: 30,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Delivery Hero',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF878787),
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    letterSpacing: -0.01,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      'Aleksandr V.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2F2E36),
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB8B8B8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.phone, color: Colors.green),
              onPressed: () {},
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.chat_rounded, color: Colors.orangeAccent),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            Expanded(
              child: Text(
                "your location",
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF878787),
                  letterSpacing: -0.01,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: responsiveHeight(context, 8)),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Color(0xFF25AE4B)),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                '123 Al-Madina Street, Abdali, Amman, Jordan',
                style: GoogleFonts.inter(
                  color: Color(0XFF878787),
                  fontSize: responsiveHeight(context, 14),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLiveTrackButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: responsiveWidth(context, 295),
        height: responsiveHeight(context, 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF85DE9E), width: 1),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF25AE4B), Color(0xFF25AE4B)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x4D253EA7),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),

          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Live Track',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: responsiveHeight(context, 14),
                height: 1.4,
                letterSpacing: -0.01,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
