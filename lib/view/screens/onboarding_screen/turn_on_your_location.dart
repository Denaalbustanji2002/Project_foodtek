import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../helper/responsive.dart';

import '../../widget/section1.dart';
import '../authentication_screens/login_screen.dart';

class TurnOnYourLocation extends StatefulWidget {
  const TurnOnYourLocation({super.key});

  @override
  State<TurnOnYourLocation> createState() => _TurnOnYourLocationState();
}

class _TurnOnYourLocationState extends State<TurnOnYourLocation> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  PageController pageController = PageController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _requestLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Location services are disabled. Please enable them.';
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permissions are denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'Location permissions are permanently denied.';
        });
        return;
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition();

      // Save the location securely
      await _storage.write(
        key: 'latitude',
        value: position.latitude.toString(),
      );
      await _storage.write(
        key: 'longitude',
        value: position.longitude.toString(),
      );

      // Navigate to the next screen after saving the location
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    section1 section = section1();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          section.buildTopImage(context, "assets/images/maps.png"),
          section.buildCenterImage(context, "assets/images/TakeAway.png"),
          section.buildWelcomeText(
            context,
            "assets/images/turn_on_your_location_text.png",
          ),

          // Continue Button
          section.buildContinueButton(
            context,
            _requestLocation,
            "Yes, Turn It On",
            responsiveHeight(context, 668),
          ),

          // Cancel Button
          section.buildCencelButton(
            context,
            (context) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            "Cancel",
            responsiveHeight(context, 728),
          ),

          // Loading Indicator
          if (_isLoading) Center(child: CircularProgressIndicator()),

          // Error Message
          if (_errorMessage.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
