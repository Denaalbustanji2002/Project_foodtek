import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: responsiveWidth(context, 430),
              height: responsiveHeight(context, 846),
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
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
                      infoWindow: const InfoWindow(title: "Selected Location"),
                    ),
                },
              ),
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
              top: responsiveHeight(context, 567),
              left: responsiveWidth(context, 46),
              child: Container(
                width: responsiveWidth(context, 343),
                height: responsiveHeight(context, 154),
                padding: EdgeInsets.all(responsiveHeight(context, 24)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                        color: const Color(0XFF878787),
                        letterSpacing: -0.01,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: responsiveHeight(context, 12)),
                    Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 15),
                          height: responsiveHeight(context, 18.46),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: const Color(0xFF4CAF50),
                            size: responsiveHeight(context, 18.46),
                          ),
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Expanded(
                          child: Text(
                            selectedAddress,
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 12),
                              fontWeight: FontWeight.w600,
                              color: const Color(0XFF6C7278),
                              letterSpacing: -0.01,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsiveHeight(context, 16)),
                    Transform.translate(
                      offset: const Offset(0, -4.6),
                      child: SizedBox(
                        height: responsiveHeight(context, 42),
                        width: responsiveWidth(context, 295),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<NavigationCubit>().goTo(ScreenIndex.DeliveryTrackingScreen);

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF25AE4B),
                            ),
                          ),
                          child: Text(
                            "Set Location",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: responsiveHeight(context, 12),
                              height: 1.4,
                              letterSpacing: -0.01,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),));
  }}

  void _performLocationSearch(String searchQuery) {
    print('Searching for location: $searchQuery');
  }


