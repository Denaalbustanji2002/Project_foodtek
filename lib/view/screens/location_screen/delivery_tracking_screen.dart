import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/app_theme_extensions.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  final LatLng _deliveryStartPoint = LatLng(-7.9778, 112.6389);
  final LatLng _deliveryEndPoint = LatLng(-7.9778, 112.6500);
  final TextEditingController searchTextEditingController =
      TextEditingController();
  GoogleMapController? _mapController;


  Set<Marker> _markers = {};

  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _setPolyline();
  }

  void _setMarkers() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('delivery_start'),
          position: _deliveryStartPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(title: 'Delivery Start'),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('delivery_end'),
          position: _deliveryEndPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'Delivery Destination'),
        ),
      );
    });
  }

  void _setPolyline() {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('delivery_route'),
          points: [_deliveryStartPoint, _deliveryEndPoint],
          color: Colors.green,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>() ?? AppThemeExtension.light;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _deliveryStartPoint,
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: responsiveHeight(context, 58),
            left: responsiveWidth(context, 16),
            child: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward
                    : Icons.arrow_back,
                color: theme.iconColor,
                size: responsiveHeight(context, 24),
              ),
              onPressed: () {
              },
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 63),
            left: responsiveWidth(context, 52),
            child: Container(
              width: responsiveWidth(context, 327),
              height: responsiveHeight(context, 42),
              decoration: BoxDecoration(
                color: theme.containerColor,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: theme.borderColor, width: 1),
              ),
              child: TextField(
                controller: searchTextEditingController,
                style: GoogleFonts.inter(
                  color: theme.textFieldTextColor,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.findYourLocation,
                  hintStyle: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 12),
                    fontWeight: FontWeight.w400,
                    color: theme.hintTextColor,
                    letterSpacing: 0.0,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: responsiveHeight(context, 22),
                    horizontal: responsiveWidth(context, 12),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: responsiveWidth(context, 16),
                      right: responsiveWidth(context, 8),
                    ),
                    child: Icon(
                      Icons.search,
                      color: theme.primaryColor,
                      size: responsiveHeight(context, 18),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: responsiveWidth(context, 42),
                    minHeight: responsiveHeight(context, 42),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.containerColor,
                ),
                onSubmitted: (value) {
                  _performLocationSearch(value);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: responsiveHeight(context, 290),
              padding: EdgeInsets.all(16),
              color: theme.containerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsiveHeight(context, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.onTheWay,
                        style: GoogleFonts.inter(
                          fontSize: responsiveHeight(context, 16),
                          fontWeight: FontWeight.w700,
                          color: theme.textColorPrimary,
                          letterSpacing: 0.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/orderDetails');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.allDetails,
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 16),
                            fontWeight: FontWeight.w700,
                            color: theme.primaryColor,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsiveHeight(context, 16)),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.orderPlaced,
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.onTheWay,
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: theme.secondaryTextColor,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.delivered,
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: theme.secondaryTextColor,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: theme.disabledColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsiveHeight(context, 32)),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.disabledColor,
                        child: Icon(Icons.person, color: theme.textColorPrimary),
                      ),
                      SizedBox(width: responsiveWidth(context, 12)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.yourDeliveryHero,
                            style: GoogleFonts.inter(
                              color: theme.secondaryTextColor,
                              fontSize: responsiveHeight(context, 12),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.01,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.aleksandrV,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: responsiveHeight(context, 14),
                                  color: theme.textColorPrimary,
                                ),
                              ),
                              SizedBox(width: responsiveWidth(context, 8)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: responsiveWidth(context, 4)),
                                  Text(
                                    '4.9',
                                    style: GoogleFonts.inter(
                                      fontSize: responsiveHeight(context, 14),
                                      fontWeight: FontWeight.w600,
                                      color: theme.secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.disabledColor,
                              ),
                              child: Icon(
                                Icons.call,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: responsiveWidth(context, 8)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/chat');
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.disabledColor,
                              ),
                              child: Icon(
                                Icons.chat_rounded,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: responsiveHeight(context, 16)),
                  Text(
                    AppLocalizations.of(context)!.yourLocation,
                    style: GoogleFonts.inter(
                      fontSize: responsiveHeight(context, 12),
                      fontWeight: FontWeight.w500,
                      color: theme.secondaryTextColor,
                      letterSpacing: -0.01,
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 8)),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: theme.primaryColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.addressLine,
                          style: GoogleFonts.inter(
                            color: theme.secondaryTextColor,
                            fontSize: responsiveHeight(context, 14),
                            fontWeight: FontWeight.w600,
                            height: 1.00,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _performLocationSearch(String searchQuery) {
    print('Searching for location: $searchQuery');
  }
}
