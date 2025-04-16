import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

import '../../helper/responsive.dart';

class SpinKitHourGlassWidget extends StatefulWidget {
  const SpinKitHourGlassWidget({super.key});

  @override
  _SpinKitHourGlassWidgetState createState() => _SpinKitHourGlassWidgetState();
}

class _SpinKitHourGlassWidgetState extends State<SpinKitHourGlassWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final spinnerColor = isDark ? Colors.white : const Color(0xFF25AE4B);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: responsiveWidth(context, 25),
            height: responsiveHeight(context, 25),
            child: SpinKitHourGlass(color: spinnerColor),
          ),
        ],
      ),
    );
  }
}
