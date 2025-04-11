import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helper/responsive.dart';
import '../chat_screen/chat_screen.dart';
import '../ordering_screens/cart_history_screen.dart';
import '../ordering_screens/favorites_screen.dart';
import '../ordering_screens/home_screen.dart';
import '../ordering_screens/order_details_screen.dart';
import '../profile_screens/profile_screen.dart';

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
    return Scaffold(
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
                Icons.arrow_back,
                color: Colors.black,
                size: responsiveHeight(context, 24),
              ),
              onPressed: () {
                Navigator.pop(context);
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Color(0xFFD6D6D6), width: 1),
              ),
              child: TextField(
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Find your location',
                  hintStyle: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 12),
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF878787),
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
                      color: Color(0xFF25AE4B),
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
                  fillColor: Colors.white,
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
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsiveHeight(context, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'On The Way',
                        style: GoogleFonts.inter(
                          fontSize: responsiveHeight(context, 16),
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C1B1F),
                          letterSpacing: 0.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
                          );
                        },
                        child: Text(
                          'All Details',
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 16),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF25AE4B),
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
                              'Order Placed',
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF25AE4B),
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: Colors.green,
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
                              'On The Way',
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: Colors.green,
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
                              'Delivered',
                              style: GoogleFonts.inter(
                                fontSize: responsiveHeight(context, 12),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: Color(0xFFACACAC),
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
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      SizedBox(width: responsiveWidth(context, 12)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Delivery Hero',
                            style: GoogleFonts.inter(
                              color: Color(0xFF878787),
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
                                'Aleksandr V.',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: responsiveHeight(context, 14),
                                  color: Color(0xFF1C1B1F),
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
                                      color: Color(0xFFACACAC),
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
                                color: Colors.grey[200],
                              ),
                              child: Icon(
                                Icons.call,
                                color: Color(0xFF25AE4B),
                              ),
                            ),
                          ),
                          SizedBox(width: responsiveWidth(context, 8)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatScreen()),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
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
                    "your location",
                    style: GoogleFonts.inter(
                      fontSize: responsiveHeight(context, 12),
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF878787),
                      letterSpacing: -0.01,
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 8)),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF25AE4B),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '123 Al-Madina Street, Abdali, Amman, Jordan',
                          style: GoogleFonts.inter(
                            color: Color(0XFF878787),
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
