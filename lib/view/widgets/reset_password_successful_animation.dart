import 'dart:ui';
import 'package:flutter/material.dart';
import '../../helper/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/app_theme_extensions.dart';

class ResetPasswordSuccessfulAnimation extends StatefulWidget {
  const ResetPasswordSuccessfulAnimation({super.key});

  @override
  _ResetPasswordSuccessfulAnimationState createState() =>
      _ResetPasswordSuccessfulAnimationState();
}

class _ResetPasswordSuccessfulAnimationState
    extends State<ResetPasswordSuccessfulAnimation>
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
      end: .2,
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
    final theme = Theme.of(context);
    final appTheme = theme.extension<AppThemeExtension>()!;

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
          Text(
            AppLocalizations.of(context)!.congratulations,
            style: TextStyle(
              fontSize: responsiveWidth(context, 32),
              fontWeight: FontWeight.w700,
              color: appTheme.buttonTextColor,
              letterSpacing: -0.02,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.passwordResetSuccessfully,
            style: TextStyle(
              fontSize: responsiveWidth(context, 22),
              fontWeight: FontWeight.w400,
              color: appTheme.buttonTextColor,
              letterSpacing: -0.01,
              height: 34 / 24,
            ),
            textAlign: TextAlign.start,
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}