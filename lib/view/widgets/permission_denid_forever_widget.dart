import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../helper/responsive.dart';
import 'package:lottie/lottie.dart';

class PermissionDenidForeverWidget extends StatelessWidget {
  const PermissionDenidForeverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: responsiveWidth(context, 250),
      height: responsiveHeight(context, 250),
      child: Lottie.asset(
        'assets/lottie/permission_denid.json',
        width: responsiveWidth(context, 150),
        height: responsiveHeight(context, 150),
      ),
    );
  }
}
