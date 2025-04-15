import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:foodtek_project/view/screens/ordering_screens/order_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubits/navigation_cubit.dart';
import '../../widgets/app_tab.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const ProfileScreen({super.key, required this.navigatorKey});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0XFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF391713),
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
            color: Color(0xFF391713),
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
          _buildUserProfileHeader(context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: Color(0XFFFFFFFF),
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
                        color: Color(0XFF1D1D1D),
                        fontSize: responsiveHeight(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      _showLanguageDialog(context, widget.navigatorKey);
                    },
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
              color: Color(0XFFFFFFFF),
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
              color: Color(0XFFFFFFFF),
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

  Widget _buildUserProfileHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey.shade200,
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
                  color: Color(0xFF1B1B1B),
                  letterSpacing: 0.0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'ahmad1709@gmail.com',
                style: GoogleFonts.inter(
                  color: Colors.grey,
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

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          title,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          style: GoogleFonts.inter(
            color: Color(0xFF1B1B1B),
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
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(icon, color: Color(0XFF1D1D1D), size: 20),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: Color(0XFF1D1D1D),
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
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: Color(0XFF1D1D1D), size: 20),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0XFF1D1D1D),
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
    showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.chooseLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.arabic),
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Future.delayed(Duration(milliseconds: 100));
                  await parentContext.read<LanguageCubit>().changeLang(
                    langCode: 'ar',
                  );
                  parentContext.read<NavigationCubit>().changeTab(AppTab.home);
                  navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.english),
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Future.delayed(Duration(milliseconds: 100));
                  await parentContext.read<LanguageCubit>().changeLang(
                    langCode: 'en',
                  );
                  parentContext.read<NavigationCubit>().changeTab(AppTab.home);
                  navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
