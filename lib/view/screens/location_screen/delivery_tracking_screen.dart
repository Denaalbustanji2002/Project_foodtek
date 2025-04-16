import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';
import '../add_to_cart/screen/history_screen.dart';
import '../chat_screen/chat_screen.dart';
import '../checkout_screens/order_details_screen.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  final LatLng _deliveryStartPoint = LatLng(-7.9778, 112.6389);
  final LatLng _deliveryEndPoint = LatLng(-7.9778, 112.6500);
  final TextEditingController searchTextEditingController = TextEditingController();
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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
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
              // Set map style for dark mode
              if (isDarkMode) {
                controller.setMapStyle('''
                  [
                    {
                      "elementType": "geometry",
                      "stylers": [
                        {
                          "color": "#242f3e"
                        }
                      ]
                    },
                    {
                      "elementType": "labels.text.fill",
                      "stylers": [
                        {
                          "color": "#746855"
                        }
                      ]
                    },
                    {
                      "elementType": "labels.text.stroke",
                      "stylers": [
                        {
                          "color": "#242f3e"
                        }
                      ]
                    }
                  ]
                ''');
              } else {
                controller.setMapStyle(null);
              }
            },
          ),
          Positioned(
            top: responsiveHeight(context, 58),
            left: responsiveWidth(context, 16),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onBackground,
                size: responsiveHeight(context, 24),
              ),
              onPressed: () {
                context.read<NavigationCubit>().pop();
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
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: TextField(
                controller: searchTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Find your location',
                  hintStyle: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 12),
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface.withOpacity(0.6),
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
                      color: colorScheme.primary,
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
                  fillColor: colorScheme.surface,
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
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  )
                ],
              ),
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
                          color: colorScheme.onSurface,
                          letterSpacing: 0.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<NavigationCubit>().goTo(ScreenIndex.OrderDetailsScreen);
                        },
                        child: Text(
                          'All Details',
                          style: GoogleFonts.inter(
                            fontSize: responsiveHeight(context, 16),
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
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
                                color: colorScheme.primary,
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
                                color: colorScheme.onSurface.withOpacity(0.6),
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
                                color: colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: responsiveHeight(context, 8)),
                            Container(
                              height: responsiveHeight(context, 6),
                              width: responsiveWidth(context, 100),
                              decoration: BoxDecoration(
                                color: colorScheme.onSurface.withOpacity(0.2),
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
                        backgroundColor: colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.person,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(width: responsiveWidth(context, 12)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Delivery Hero',
                            style: GoogleFonts.inter(
                              color: colorScheme.onSurface.withOpacity(0.6),
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
                                  color: colorScheme.onSurface,
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
                                      color: colorScheme.onSurface.withOpacity(0.6),
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
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surfaceVariant,
                              ),
                              child: Icon(
                                Icons.call,
                                color:Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: responsiveWidth(context, 8)),
                          GestureDetector(
                            onTap: () {
                              context.read<NavigationCubit>().goTo(ScreenIndex.ChatScreen);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surfaceVariant,
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
                      color: colorScheme.onSurface.withOpacity(0.6),
                      letterSpacing: -0.01,
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 8)),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: colorScheme.primary,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '123 Al-Madina Street, Abdali, Amman, Jordan',
                          style: GoogleFonts.inter(
                            color: colorScheme.onSurface.withOpacity(0.6),
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