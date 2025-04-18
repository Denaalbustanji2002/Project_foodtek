import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/app_theme_extensions.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;
  LatLng? selectedLocation;
  String selectedAddress = "Select a location";
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<AppThemeExtension>()!;

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
                      infoWindow: InfoWindow(title: AppLocalizations.of(context)!.selectedLocationTitle),
                    ),
                },
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 58),
              left: responsiveWidth(context, 16),
              child: IconButton(
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.arrow_forward
                      : Icons.arrow_back,
                  color: themeExtension.textColorPrimary,
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
                  color: themeExtension.backgroundColor,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: themeExtension.borderColor, width: 1),
                ),
                child: TextField(
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.findYourLocation,
                    hintStyle: GoogleFonts.inter(
                      fontSize: responsiveHeight(context, 12),
                      fontWeight: FontWeight.w400,
                      color: themeExtension.secondaryTextColor,
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
                        color: themeExtension.primaryColor,
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
                    fillColor: themeExtension.backgroundColor,
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
                  color: themeExtension.containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.yourLocation,
                      style: GoogleFonts.inter(
                        fontSize: responsiveHeight(context, 12),
                        fontWeight: FontWeight.w500,
                        color: themeExtension.secondaryTextColor,
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
                            color: themeExtension.primaryColor,
                            size: responsiveHeight(context, 18.46),
                          ),
                        ),
                        SizedBox(width: responsiveWidth(context, 8)),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.addressLine,
                            style: GoogleFonts.inter(
                              fontSize: responsiveHeight(context, 12),
                              fontWeight: FontWeight.w600,
                              color: themeExtension.secondaryTextColor,
                              letterSpacing: -0.01,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsiveHeight(context, 15)),
                    Transform.translate(
                      offset: const Offset(0, -4.6),
                      child: SizedBox(
                        height: responsiveHeight(context, 42),
                        width: responsiveWidth(context, 295),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                              themeExtension.primaryColor,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.setLocation,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: responsiveHeight(context, 12),
                              height: 1.4,
                              letterSpacing: -0.01,
                              color: themeExtension.buttonTextColor,
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
        ),
      ),
    );
  }
  void _performLocationSearch(String searchQuery) {
    print('Searching for location: $searchQuery');
  }
}
