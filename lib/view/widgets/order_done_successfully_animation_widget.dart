import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDoneSuccessfullyAnimationWidget extends StatefulWidget {
  const OrderDoneSuccessfullyAnimationWidget({super.key});

  @override
  _OrderDoneSuccessfullyAnimationWidgetState createState() =>
      _OrderDoneSuccessfullyAnimationWidgetState();
}

class _OrderDoneSuccessfullyAnimationWidgetState
    extends State<OrderDoneSuccessfullyAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: responsiveWidth(context, 430.5),
      height: responsiveHeight(context, 420),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: AnimatedOpacity(
              opacity: _fadeAnimation.value,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: responsiveHeight(context, 287),
                width: responsiveWidth(context, 430.5),
                child: Image.asset(
                  'assets/images/reset_password_successful_animation.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
