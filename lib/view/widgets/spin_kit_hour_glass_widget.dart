import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class SpinKitHourGlassWidget extends StatefulWidget {
  const SpinKitHourGlassWidget({super.key});

  @override
  _SpinKitHourGlassWidgetState createState() => _SpinKitHourGlassWidgetState();
}

class _SpinKitHourGlassWidgetState extends State<SpinKitHourGlassWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: responsiveWidth(context, 25),
            height: responsiveHeight(context, 25),
            child: SpinKitHourGlass(color: Color(0xFF25AE4B)),
          ),
        ],
      ),
    );
  }
}
