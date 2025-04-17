import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:foodtek_project/view/screens/ordering_screens/order_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/language_cubit.dart';
import '../../../cubits/theme_cubit.dart'; // Import the theme cubit
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubits/navigation_cubit.dart';
import '../../../theme/app_theme_extensions.dart';
import '../../widgets/app_tab.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const ProfileScreen({super.key, required this.navigatorKey});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    // Get the current theme state
    final themeExtension = Theme.of(context).extension<AppThemeExtension>()!;
    final isDarkMode = context.watch<ThemeCubit>().isDarkMode;

    return Scaffold(
      backgroundColor: themeExtension.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeExtension.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: themeExtension.titleColor,
          iconSize: responsiveHeight(context, 20),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
            );
          },
        ),
        toolbarHeight: 50,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 20),
            fontWeight: FontWeight.w600,
            color: themeExtension.titleColor,
            letterSpacing: 0.0,
            height: 1.0,
          ),
        ),
        titleSpacing: 0.0,
        leadingWidth: responsiveWidth(context, 40),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          _buildUserProfileHeader(context, themeExtension),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: themeExtension.containerColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildSectionTitle(
                      AppLocalizations.of(context)!.myAccount,
                      context,
                    ),
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.person_outline,
                    title: AppLocalizations.of(context)!.personalInformation,
                    onTap: () {
                      Navigator.pushNamed(context, '/profileDetails');
                    },
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.language,
                    title: AppLocalizations.of(context)!.language,
                    trailing: Text(
                      'عربية',
                      style: GoogleFonts.cairo(
                        color: themeExtension.labelTextColor,
                        fontSize: responsiveHeight(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _showLanguageDialog(context, widget.navigatorKey);
                    },
                  ),
                  _buildThemeToggleMenuItem(
                    context: context,
                    isDarkMode: isDarkMode,
                    themeExtension: themeExtension,
                    navigatorKey: widget.navigatorKey,
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: AppLocalizations.of(context)!.privacyPolicy,
                    onTap: () {},
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: AppLocalizations.of(context)!.setting,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: themeExtension.containerColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSectionTitle(
                    AppLocalizations.of(context)!.notifications,
                    context,
                  ),
                  _buildSwitchMenuItem(
                    icon: Icons.notifications_outlined,
                    title: AppLocalizations.of(context)!.pushNotifications,
                    value: true,
                  ),
                  _buildSwitchMenuItem(
                    icon: Icons.notifications_outlined,
                    title:
                        AppLocalizations.of(context)!.promotionalNotifications,
                    value: false,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: responsiveHeight(context, 8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: themeExtension.containerColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSectionTitle(
                    AppLocalizations.of(context)!.more,
                    context,
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.help_outline,
                    title: AppLocalizations.of(context)!.helpCenter,
                    onTap: () {},
                  ),
                  _buildLogoutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggleMenuItem({
    required BuildContext context,
    required bool isDarkMode,
    required AppThemeExtension themeExtension,
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: themeExtension.iconColor,
        size: 20,
      ),
      title: Text(
        isDarkMode
            ? AppLocalizations.of(context)?.darkMode ?? 'Dark Mode'
            : AppLocalizations.of(context)?.lightMode ?? 'Light Mode',
        style: GoogleFonts.inter(
          color: themeExtension.titleColor,
          fontSize: responsiveHeight(context, 14),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(
          activeColor: Color(0XFFFFFFFF),
          activeTrackColor: Color(0XFF09CA67),
          inactiveTrackColor: Color(0XFFAFAFAF),
          inactiveThumbColor: Color(0XFFFFFFFF),
          value: isDarkMode,
          onChanged: (bool newValue) async {
            // تأخير قليل للسماح للواجهة بالاستجابة
            await Future.delayed(Duration(milliseconds: 100));

            // تبديل السمة
            context.read<ThemeCubit>().toggleTheme();

            // تغيير علامة التبويب إلى الصفحة الرئيسية
            context.read<NavigationCubit>().changeTab(AppTab.home);

            // الانتقال إلى الصفحة الرئيسية
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserProfileHeader(
    BuildContext context,
    AppThemeExtension themeExtension,
  ) {
    final brightness =
        Theme.of(
          context,
        ).brightness; // الحصول على Brightness من Theme.of(context)

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor:
                brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
            child: Image.asset(
              "assets/images/profile_picture.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Ahmad Daboor',
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 16),
                  fontWeight: FontWeight.w500,
                  color: themeExtension.titleColor,
                  letterSpacing: 0.0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'ahmad1709@gmail.com',
                style: GoogleFonts.inter(
                  color: themeExtension.labelTextColor,
                  fontSize: responsiveHeight(context, 14),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.0,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // احصل على الألوان من AppThemeExtension
    final themeExtension = Theme.of(context).extension<AppThemeExtension>();

    // تأكد من أن themeExtension ليس null
    final theme = themeExtension ?? AppThemeExtension.light;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          title,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          style: GoogleFonts.inter(
            color: themeExtension?.titleColor ?? Colors.black,
            // استخدم color من AppThemeExtension
            fontWeight: FontWeight.w500,
            fontSize: responsiveHeight(context, 16),
            letterSpacing: 0.0,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final themeExtension =
        theme.extension<AppThemeExtension>(); // إضافة هذه السطر

    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(
        icon,
        color: themeExtension?.iconColor ?? Colors.black,
        size: 20,
      ),
      // استخدام themeExtension
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: themeExtension?.titleColor ?? Colors.black,
          // استخدام themeExtension
          fontSize: responsiveHeight(context, 14),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildSwitchMenuItem({
    required IconData icon,
    required String title,
    required bool value,
  }) {
    final theme = Theme.of(context);
    final themeExtension =
        theme.extension<AppThemeExtension>(); // إضافة هذه السطر

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(
        icon,
        color: themeExtension?.iconColor ?? Colors.black,
        size: 20,
      ),
      // استخدام themeExtension
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color:
              themeExtension?.titleColor ??
              Colors.black, // استخدام themeExtension
        ),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(
          activeColor: Color(0XFFFFFFFF),
          activeTrackColor: Color(0XFF09CA67),
          inactiveTrackColor: Color(0XFFAFAFAF),
          inactiveThumbColor: Color(0XFFFFFFFF),
          value: value,
          onChanged: (bool newValue) {},
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(Icons.logout, color: Colors.red, size: 20),
      title: Text(
        AppLocalizations.of(context)!.logOut,
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {},
    );
  }

  void _showLanguageDialog(
      BuildContext parentContext,
      GlobalKey<NavigatorState> navigatorKey,
      ) {
    final themeExtension = Theme.of(parentContext).extension<AppThemeExtension>();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: themeExtension?.containerColor ?? Colors.white,
          title: Text(
            AppLocalizations.of(dialogContext)!.chooseLanguage,
            style: TextStyle(color: themeExtension?.titleColor ?? Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===== Arabic Option =====
              ListTile(
                title: Text(
                  AppLocalizations.of(dialogContext)!.arabic,
                  style: TextStyle(color: themeExtension?.titleColor ?? Colors.black),
                ),
                onTap: () {
                  final langCubit = parentContext.read<LanguageCubit>();
                  final navCubit  = parentContext.read<NavigationCubit>();

                  Navigator.of(dialogContext).pop();

                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    if (!parentContext.mounted) return;

                    await langCubit.changeLang(langCode: 'ar');
                    navCubit.changeTab(AppTab.home);
                    navigatorKey.currentState!
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  });
                },
              ),

              // ===== English Option =====
              ListTile(
                title: Text(
                  AppLocalizations.of(dialogContext)!.english,
                  style: TextStyle(color: themeExtension?.titleColor ?? Colors.black),
                ),
                onTap: () {
                  final langCubit = parentContext.read<LanguageCubit>();
                  final navCubit  = parentContext.read<NavigationCubit>();

                  Navigator.of(dialogContext).pop();

                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    if (!parentContext.mounted) return;

                    await langCubit.changeLang(langCode: 'en');
                    navCubit.changeTab(AppTab.home);
                    navigatorKey.currentState!
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}