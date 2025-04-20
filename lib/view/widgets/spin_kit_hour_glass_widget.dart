import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import '../../theme/app_theme_extensions.dart';

class SpinKitHourGlassWidget extends StatefulWidget {
  const SpinKitHourGlassWidget({super.key});

  @override
  _SpinKitHourGlassWidgetState createState() => _SpinKitHourGlassWidgetState();
}

class _SpinKitHourGlassWidgetState extends State<SpinKitHourGlassWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: responsiveWidth(context, 25),
            height: responsiveHeight(context, 25),
            child: SpinKitHourGlass(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
