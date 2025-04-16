import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;
  LatLng? selectedLocation;
  String selectedAddress = "Select a location";
  TextEditingController searchTextEditingController = TextEditingController();
  int selectedIndex = 2;
  Position? _currentPosition;

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    searchTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
      _goToCurrentLocation();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _goToCurrentLocation() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
      setState(() {
        selectedLocation = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
        selectedAddress = "Current location (${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)})";
      });
    }
  }

  Future<void> _performLocationSearch(String searchQuery) async {
    if (searchQuery.isEmpty) return;

    print('Searching for location: $searchQuery');
    setState(() {
      selectedAddress = "Searching for '$searchQuery'...";
    });

    await Future.delayed(Duration(seconds: 1));

    // Simulated search results - replace with actual API call in production
    setState(() {
      selectedLocation = LatLng(
        37.7749 + (searchQuery.length * 0.001),
        -122.4194 + (searchQuery.length * 0.001),
      );
      selectedAddress = "Found: $searchQuery (${selectedLocation!.latitude.toStringAsFixed(4)}, ${selectedLocation!.longitude.toStringAsFixed(4)})";
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(selectedLocation!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                initialCameraPosition: _kInitialPosition,
                mapType: isDarkMode ? MapType.normal : MapType.normal,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                onMapCreated: (controller) {
                  setState(() {
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
                  });
                },
                onTap: (LatLng position) {
                  setState(() {
                    selectedLocation = position;
                    selectedAddress =
                    "Selected location (${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)})";
                  });
                },
                markers: {
                  if (selectedLocation != null)
                    Marker(
                      markerId: const MarkerId("selectedLocation"),
                      position: selectedLocation!,
                      infoWindow: InfoWindow(title: selectedAddress),
                    ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),

            Positioned(
              top: responsiveHeight(context, 58),
              left: responsiveWidth(context, 10),
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
              bottom: responsiveHeight(context, 100),
              left: responsiveWidth(context, 46),
              child: Container(
                width: responsiveWidth(context, 343),
                height: responsiveHeight(context, 154),
                padding: EdgeInsets.all(responsiveHeight(context, 24)),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "your location",
                      style: GoogleFonts.inter(
                        fontSize: responsiveHeight(context, 12),
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface.withOpacity(0.6),
                        letterSpacing: -0.01,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: responsiveHeight(context, 12)),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: colorScheme.primary,
                          size: responsiveHeight(context, 18.46),
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Expanded(
                          child: Text(
                            selectedAddress,
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 12),
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                              letterSpacing: -0.01,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsiveHeight(context, 16)),
                    SizedBox(
                      height: responsiveHeight(context, 42),
                      width: responsiveWidth(context, 295),
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedLocation != null) {
                            context.read<NavigationCubit>().goTo(ScreenIndex.DeliveryTrackingScreen);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please select a location first"),
                                backgroundColor: colorScheme.error,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Set Location",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: responsiveHeight(context, 12),
                            height: 1.4,
                            letterSpacing: -0.01,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: responsiveHeight(context, 180),
              right: responsiveWidth(context, 20),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: colorScheme.surface,
                onPressed: _goToCurrentLocation,
                child: Icon(
                  Icons.my_location,
                  color: colorScheme.primary,
                  size: responsiveHeight(context, 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}