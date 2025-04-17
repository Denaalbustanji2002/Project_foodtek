import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import '../../../theme/app_theme_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeExtension>()!;
    return Scaffold(
      appBar: _buildAppBar(context, colors),
      body: _buildBody(context, colors),
    );
  }

  AppBar _buildAppBar(BuildContext context,  AppThemeExtension colors) {
    return AppBar(
      leading: SizedBox(
        width: 30,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          color: colors.textColorPrimary,
          iconSize: responsiveHeight(context, 20),
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/deliveryTracking');
          },
        ),
      ),
      leadingWidth: 30,
      titleSpacing: 0,
      title: Text(
        AppLocalizations.of(context)!.orderDetails,
        style: GoogleFonts.inter(
          fontSize: responsiveHeight(context, 20),
          fontWeight: FontWeight.w600,
          color: colors.textColorPrimary,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context,  AppThemeExtension colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderInfo(colors),
          SizedBox(height: 20),
          _buildTrackingSteps(colors),
          SizedBox(height: 20),
          _buildDeliveryHeroCard(context, colors),
          SizedBox(height: 20),
          _buildLocationDetails(context, colors),
          SizedBox(height: 100),
          _buildLiveTrackButton(context, colors),
        ],
      ),
    );
  }

  Widget _buildOrderInfo( AppThemeExtension colors) {
    return Row(
      children: [
        _buildIconContainer("assets/icons/takeaway_icon.png"),
        SizedBox(width: 10),
        _buildOrderDetails(colors),
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

  Widget _buildOrderDetails( AppThemeExtension colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.orderId,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: colors.textColorPrimary,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            AppLocalizations.of(context)!.orderIdNumber,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: colors.secondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.orderDistance,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: colors.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSteps( AppThemeExtension colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrackingStep(AppLocalizations.of(context)!.orderReceived, Icons.check, true, false, colors),
        _buildTrackingStep(AppLocalizations.of(context)!.cookingYourOrder, Icons.kitchen_outlined, true, false, colors),
        _buildTrackingStep(AppLocalizations.of(context)!.courierIsPickingUp, Icons.person, true, false, colors),
        _buildTrackingStep(AppLocalizations.of(context)!.orderDelivered, Icons.home, false, true, colors),
      ],
    );
  }

  Widget _buildTrackingStep(String text, IconData icon, bool isCompleted, bool isLast,  AppThemeExtension colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isCompleted ? colors.primaryColor : colors.disabledColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.black54,
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 20,
                color: isCompleted ? colors.primaryColor : colors.disabledColor,
              ),
          ],
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: colors.textColorPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryHeroCard(BuildContext context,  AppThemeExtension colors) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage('assets/images/delivery_hero_photo.png'), radius: 30),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourDeliveryHero,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.aleksandrV,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: colors.textColorPrimary,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: colors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone, color: colors.primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_rounded, color: Colors.orangeAccent),
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails(BuildContext context,  AppThemeExtension colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.yourLocation,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            fontWeight: FontWeight.w500,
            color: colors.secondaryTextColor,
          ),
        ),
        SizedBox(height: responsiveHeight(context, 8)),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: colors.primaryColor),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.addressLine,
                style: GoogleFonts.inter(
                  color: colors.secondaryTextColor,
                  fontSize: responsiveHeight(context, 14),
                  fontWeight: FontWeight.w600,
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

  Widget _buildLiveTrackButton(BuildContext context,  AppThemeExtension colors) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: responsiveWidth(context, 295),
        height: responsiveHeight(context, 48),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/deliveryTracking');
            },
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.primaryColor.withOpacity(0.5), width: 1),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.primaryColor, colors.primaryColor],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4D253EA7),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.liveTrack,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
