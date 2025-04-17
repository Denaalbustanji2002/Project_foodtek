import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color primaryColor;
  final Color textColorPrimary;
  final Color secondaryTextColor;
  final Color disabledColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Color iconColor;
  final Color titleColor;
  final Color containerColor;
  final Color borderColor;
  final Color shadowColor;
  final Color labelTextColor;
  final Color textFieldTextColor;
  final Color scaffoldBackgroundColor;
  final Color buttonTextColor;
  final Color hintTextColor;
  final Color surfaceColor;
  final Color deleteButtonColor;
  final Color spicyRedColor;
  final Color mildGreenColor;
  final Color minMaxColor;
  final Color inactiveTrackColor;
  final Color filterCategoryContainerColor;
  final Color filterCategoryTextSelectedColor;
  final Color filterCategoryTextUnSelectedColor;
  final Color filterCategorySelectedContainerColor;
  final Color filterCategoryUnSelectedContainerColor;
  final Color chatReceivedMessageColor;
  final Color bottomNavBarBackgroundColor;
  final Color bottomNavBarShadowColor;
  final Color bottomNavBarSelectedIconColor;
  final Color bottomNavBarUnselectedIconColor;
  final Color bottomNavBarSelectedTextColor;
  final Color bottomNavBarUnselectedTextColor;
  final Color splashScreenColor;
  final Color resetPasswordSuccessTextColor;
  final Color resetPasswordSuccessSubtitleTextColor;

  const AppThemeExtension({
    required this.primaryColor,
    required this.textColorPrimary,
    required this.secondaryTextColor,
    required this.disabledColor,
    required this.backgroundColor,
    required this.appBarColor,
    required this.iconColor,
    required this.titleColor,
    required this.containerColor,
    required this.borderColor,
    required this.shadowColor,
    required this.labelTextColor,
    required this.textFieldTextColor,
    this.scaffoldBackgroundColor = const Color(0xFFFFFFFF),
    this.buttonTextColor = const Color(0xFFFFFFFF),
    this.hintTextColor = const Color(0xFFB0B0B0),
    this.surfaceColor = const Color(0xFFFFFFFF),
    this.deleteButtonColor = const Color(0xFFE0E0E0),
    this.spicyRedColor = const Color(0xFFEF2A39),
    this.mildGreenColor = const Color(0xFFDBF4D1),
    this.minMaxColor = const Color(0xFF25AE4B),
    this.inactiveTrackColor = const Color(0xFF25AE4B),
    this.filterCategoryContainerColor = const Color(0xFF25AE4B),
    this.filterCategoryTextSelectedColor = const Color(0xFF455A64),
    this.filterCategoryTextUnSelectedColor = const Color(0xFF455A64),
    this.filterCategorySelectedContainerColor = const Color(0xFF25AE4B),
    this.filterCategoryUnSelectedContainerColor = const Color(0xFFEDF1F3),
    this.chatReceivedMessageColor = const Color(0xFFEEEEEE),
    this.bottomNavBarBackgroundColor = const Color(0xFFDBF4D1),
    this.bottomNavBarShadowColor = const Color(0xFFDBF4D1),
    this.bottomNavBarSelectedIconColor = const Color(0xFF25AE4B),
    this.bottomNavBarUnselectedIconColor = const Color(0xFF484C52),
    this.bottomNavBarSelectedTextColor = const Color(0xFF25AE4B),
    this.bottomNavBarUnselectedTextColor = const Color(0xFF484C52),
    this.resetPasswordSuccessTextColor = const Color(0xFFFFFFFF),
    this.resetPasswordSuccessSubtitleTextColor = const Color(0xFFFFFFFF),
    this.splashScreenColor = const Color(0xFF25AE4B),
  });

  @override
  AppThemeExtension copyWith({
    Color? primaryColor,
    Color? textColorPrimary,
    Color? secondaryTextColor,
    Color? disabledColor,
    Color? backgroundColor,
    Color? appBarColor,
    Color? iconColor,
    Color? titleColor,
    Color? containerColor,
    Color? borderColor,
    Color? shadowColor,
    Color? labelTextColor,
    Color? textFieldTextColor,
    Color? scaffoldBackgroundColor,
    Color? buttonTextColor,
    Color? hintTextColor,
    Color? surfaceColor,
    Color? deleteButtonColor,
    Color? spicyRedColor,
    Color? mildGreenColor,
    Color? minMaxColor,
    Color? inactiveTrackColor,
    Color? filterCategoryContainerColor,
    Color? filterCategoryTextSelectedColor,
    Color? filterCategoryTextUnSelectedColor,
    Color? filterCategorySelectedContainerColor,
    Color? filterCategoryUnSelectedContainerColor,
    Color? chatReceivedMessageColor,
    Color? bottomNavBarBackgroundColor,
    Color? bottomNavBarShadowColor,
    Color? bottomNavBarSelectedIconColor,
    Color? bottomNavBarUnselectedIconColor,
    Color? bottomNavBarSelectedTextColor,
    Color? bottomNavBarUnselectedTextColor,
    Color? resetPasswordSuccessTextColor,
    Color? resetPasswordSuccessSubtitleTextColor,
    Color? splashScreenColor,
  }) {
    return AppThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      textColorPrimary: textColorPrimary ?? this.textColorPrimary,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      disabledColor: disabledColor ?? this.disabledColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      appBarColor: appBarColor ?? this.appBarColor,
      iconColor: iconColor ?? this.iconColor,
      titleColor: titleColor ?? this.titleColor,
      containerColor: containerColor ?? this.containerColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      textFieldTextColor: textFieldTextColor ?? this.textFieldTextColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      deleteButtonColor: deleteButtonColor ?? this.deleteButtonColor,
      spicyRedColor: spicyRedColor ?? this.spicyRedColor,
      mildGreenColor: mildGreenColor ?? this.mildGreenColor,
      minMaxColor: minMaxColor ?? this.minMaxColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      filterCategoryContainerColor: filterCategoryContainerColor ?? this.filterCategoryContainerColor,
      filterCategoryTextSelectedColor: filterCategoryTextSelectedColor ?? this.filterCategoryTextSelectedColor,
      filterCategoryTextUnSelectedColor: filterCategoryTextUnSelectedColor ?? this.filterCategoryTextUnSelectedColor,
      filterCategorySelectedContainerColor: filterCategorySelectedContainerColor ?? this.filterCategorySelectedContainerColor,
      filterCategoryUnSelectedContainerColor: filterCategoryUnSelectedContainerColor ?? this.filterCategoryUnSelectedContainerColor,
      chatReceivedMessageColor: chatReceivedMessageColor ?? this.chatReceivedMessageColor,
      bottomNavBarBackgroundColor: bottomNavBarBackgroundColor ?? this.bottomNavBarBackgroundColor,
      bottomNavBarShadowColor: bottomNavBarShadowColor ?? this.bottomNavBarShadowColor,
      bottomNavBarSelectedIconColor: bottomNavBarSelectedIconColor ?? this.bottomNavBarSelectedIconColor,
      bottomNavBarUnselectedIconColor: bottomNavBarUnselectedIconColor ?? this.bottomNavBarUnselectedIconColor,
      bottomNavBarSelectedTextColor: bottomNavBarSelectedTextColor ?? this.bottomNavBarSelectedTextColor,
      bottomNavBarUnselectedTextColor: bottomNavBarUnselectedTextColor ?? this.bottomNavBarUnselectedTextColor,
      resetPasswordSuccessTextColor: resetPasswordSuccessTextColor ?? this.resetPasswordSuccessTextColor,
      resetPasswordSuccessSubtitleTextColor: resetPasswordSuccessSubtitleTextColor ?? this.resetPasswordSuccessSubtitleTextColor,
      splashScreenColor: splashScreenColor ?? this.splashScreenColor,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      textColorPrimary: Color.lerp(textColorPrimary, other.textColorPrimary, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
      containerColor: Color.lerp(containerColor, other.containerColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t)!,
      textFieldTextColor: Color.lerp(textFieldTextColor, other.textFieldTextColor, t)!,
      scaffoldBackgroundColor: Color.lerp(scaffoldBackgroundColor, other.scaffoldBackgroundColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      deleteButtonColor: Color.lerp(deleteButtonColor, other.deleteButtonColor, t)!,
      spicyRedColor: Color.lerp(spicyRedColor, other.spicyRedColor, t)!,
      mildGreenColor: Color.lerp(mildGreenColor, other.mildGreenColor, t)!,
      minMaxColor: Color.lerp(minMaxColor, other.minMaxColor, t)!,
      inactiveTrackColor: Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t)!,
      filterCategoryContainerColor: Color.lerp(filterCategoryContainerColor, other.filterCategoryContainerColor, t)!,
      filterCategoryTextSelectedColor: Color.lerp(filterCategoryTextSelectedColor, other.filterCategoryTextSelectedColor, t)!,
      filterCategoryTextUnSelectedColor: Color.lerp(filterCategoryTextUnSelectedColor, other.filterCategoryTextUnSelectedColor, t)!,
      filterCategorySelectedContainerColor: Color.lerp(filterCategorySelectedContainerColor, other.filterCategorySelectedContainerColor, t)!,
      filterCategoryUnSelectedContainerColor: Color.lerp(filterCategoryUnSelectedContainerColor, other.filterCategoryUnSelectedContainerColor, t)!,
      chatReceivedMessageColor: Color.lerp(chatReceivedMessageColor, other.chatReceivedMessageColor, t)!,
      bottomNavBarBackgroundColor: Color.lerp(bottomNavBarBackgroundColor, other.bottomNavBarBackgroundColor, t)!,
      bottomNavBarShadowColor: Color.lerp(bottomNavBarShadowColor, other.bottomNavBarShadowColor, t)!,
      bottomNavBarSelectedIconColor: Color.lerp(bottomNavBarSelectedIconColor, other.bottomNavBarSelectedIconColor, t)!,
      bottomNavBarUnselectedIconColor: Color.lerp(bottomNavBarUnselectedIconColor, other.bottomNavBarUnselectedIconColor, t)!,
      bottomNavBarSelectedTextColor: Color.lerp(bottomNavBarSelectedTextColor, other.bottomNavBarSelectedTextColor, t)!,
      bottomNavBarUnselectedTextColor: Color.lerp(bottomNavBarUnselectedTextColor, other.bottomNavBarUnselectedTextColor, t)!,
      resetPasswordSuccessTextColor: Color.lerp(resetPasswordSuccessTextColor, other.resetPasswordSuccessTextColor, t)!,
      resetPasswordSuccessSubtitleTextColor: Color.lerp(resetPasswordSuccessSubtitleTextColor, other.resetPasswordSuccessSubtitleTextColor, t)!,
      splashScreenColor: Color.lerp(splashScreenColor, other.splashScreenColor, t)!,

    );
  }

  static const light = AppThemeExtension(
    primaryColor: Color(0xFF25AE4B),
    textColorPrimary: Colors.black,
    secondaryTextColor: Color(0xFF7D7D7D),
    disabledColor: Color(0xFFE0E0E0),
    backgroundColor: Color(0xFFFFFFFF),
    appBarColor: Color(0xFFffffff),
    iconColor: Color(0xFF1C1C1C),
    titleColor: Color(0xFF1B1B1B),
    containerColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFFDDDDDD),
    shadowColor: Color(0x0A000000),
    labelTextColor: Color(0xFF1B1B1B),
    textFieldTextColor: Color(0xFF4F4F4F),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    buttonTextColor: Color(0xFFFFFFFF),
    hintTextColor: Color(0xFFB0B0B0),
    surfaceColor: Color(0xFFFFFFFF),
    deleteButtonColor: Color(0xFFFDAC1D),
    spicyRedColor: Color(0xFFEF2A39),
    mildGreenColor: Color(0xFFDBF4D1),
    minMaxColor: Color(0xFF455A64),
    inactiveTrackColor: Color(0xFF25AE4B),
    filterCategoryContainerColor: Color(0xFFF2F4F7),
    filterCategoryTextSelectedColor: Color(0xFF455A64),
    filterCategoryTextUnSelectedColor: Color(0xFF455A64),
    filterCategorySelectedContainerColor: Color(0xFF25AE4B),
    filterCategoryUnSelectedContainerColor: Color(0xFFEDF1F3),
    chatReceivedMessageColor: Color(0xFFEEEEEE),
    bottomNavBarBackgroundColor: Color(0xFFDBF4D1),
    bottomNavBarShadowColor: Color(0xFFDBF4D1),
    bottomNavBarSelectedIconColor: Color(0xFF25AE4B),
    bottomNavBarUnselectedIconColor: Color(0xFF484C52),
    bottomNavBarSelectedTextColor: Color(0xFF25AE4B),
    bottomNavBarUnselectedTextColor: Color(0xFF484C52),
    resetPasswordSuccessTextColor: Color(0xFFFFFFFF),
    resetPasswordSuccessSubtitleTextColor: Color(0xFFFFFFFF),
    splashScreenColor: Color(0xFF25AE4B),
  );

  static const dark = AppThemeExtension(
    primaryColor: Color(0xFF25AE4B),
    textColorPrimary: Color(0xFFFFFFFF),
    secondaryTextColor: Color(0xFFB0B0B0),
    disabledColor: Color(0xFF4F4F4F),
    backgroundColor: Color(0xFF121212),
    appBarColor: Color(0xFF1F1F1F),
    iconColor: Color(0xFFB0B0B0),
    titleColor: Colors.white,
    containerColor: Color(0xFF2C2C2C),
    borderColor: Color(0xFF444444),
    shadowColor: Color(0x3D000000),
    labelTextColor: Color(0xFFB0B0B0),
    textFieldTextColor: Color(0xFFE0E0E0),
    scaffoldBackgroundColor: Color(0xFF121212),
    buttonTextColor: Colors.white,
    hintTextColor: Color(0xFFB0B0B0),
    surfaceColor: Color(0xFF1F1F1F),
    deleteButtonColor: Color(0xFFFDAC1D),
    spicyRedColor: Color(0xFFEF2A39),
    mildGreenColor: Color(0xFF205A33),
    minMaxColor: Color(0xFF455A64),
    filterCategoryContainerColor: Color(0xFF2D3B42),
    filterCategoryTextSelectedColor: Color(0xFFE0E0E0),
    filterCategoryTextUnSelectedColor: Color(0xFFB0B0B0),
    filterCategorySelectedContainerColor: Color(0xFF25AE4B),
    filterCategoryUnSelectedContainerColor: Color(0xFF2C2C2C),
    chatReceivedMessageColor: Colors.grey,
    bottomNavBarBackgroundColor: Color(0xFF1F1F1F),
    bottomNavBarShadowColor: Color(0xFF1F1F1F),
    bottomNavBarSelectedIconColor: Color(0xFF25AE4B),
    bottomNavBarUnselectedIconColor: Color(0xFFB0B0B0),
    bottomNavBarSelectedTextColor: Color(0xFF25AE4B),
    bottomNavBarUnselectedTextColor: Color(0xFFB0B0B0),
    resetPasswordSuccessTextColor: Color(0xFFFFFFFF),
    resetPasswordSuccessSubtitleTextColor: Color(0xFFEEEEEE),
    splashScreenColor: Colors.black38,

  );
}