import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtec/view/screens/profile_screens/profile_screen_details.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/screen_index.dart';
import '../../../cubits/ThemeCubit.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/ThemeState.dart';
import '../add_to_cart/screen/history_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: colorScheme.onBackground,
          iconSize: responsiveHeight(context, 20),
          onPressed: () {},
        ),
        toolbarHeight: 50,
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 20),
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
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
              color: colorScheme.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _buildSectionTitle('My Account', context),
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.person_outline,
                    title: 'Personal information',
                    onTap: () {
                      context.read<NavigationCubit>().goTo(ScreenIndex.ProfileScreenDetails);
                    },
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.language,
                    title: 'Language',
                    trailing: Text(
                      'عربية',
                      style: GoogleFonts.cairo(
                        color: colorScheme.onSurface,
                        fontSize: responsiveHeight(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {},
                  ),
                  _buildThemeModeMenuItem(context),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: 'Setting',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: colorScheme.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSectionTitle('Notifications', context),
                  _buildSwitchMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    value: true,
                  ),
                  _buildSwitchMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Promotional Notifications',
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
              color: colorScheme.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSectionTitle('More', context),
                  _buildProfileMenuItem(
                    context: context,
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: colorScheme.surfaceVariant,
            child: Icon(
              Icons.person,
              size: responsiveHeight(context, 60),
              color: colorScheme.onSurfaceVariant,
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
                  color: colorScheme.onBackground,
                  letterSpacing: 0.0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'ahmad1709@gmail.com',
                style: GoogleFonts.inter(
                  color: colorScheme.onSurface.withOpacity(0.6),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: colorScheme.onBackground,
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
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(
          icon,
          color: colorScheme.onSurface,
          size: 20
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: colorScheme.onSurface,
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
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(
          icon,
          color: colorScheme.onSurface,
          size: 20
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(
          activeColor: colorScheme.onPrimary,
          activeTrackColor: Colors.green,
          inactiveTrackColor: colorScheme.outline.withOpacity(0.5),
          inactiveThumbColor: colorScheme.onPrimary,
          value: value,
          onChanged: (bool newValue) {},
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 24,
      leading: Icon(
          Icons.logout,
          color: colorScheme.error,
          size: 20
      ),
      title: Text(
          'Log Out',
          style: TextStyle(color: colorScheme.error)
      ),
      onTap: () {},
    );
  }

  Widget _buildThemeModeMenuItem(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = context.read<ThemeCubit>().isDarkMode;
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(
            isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            color: colorScheme.onSurface,
          ),
          title: Text(
            isDark ? 'Dark Mode' : 'Light Mode',
            style: GoogleFonts.inter(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Transform.scale(
            scale: 0.7,
            child: Switch(
              activeColor: colorScheme.onPrimary,
              activeTrackColor: Colors.green,
              inactiveTrackColor: colorScheme.outline.withOpacity(0.5),
              inactiveThumbColor: colorScheme.onPrimary,
              value: isDark,
              onChanged: (value) {
                context.read<ThemeCubit>().changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),
          onTap: () {
            context.read<ThemeCubit>().changeTheme(
              isDark ? ThemeMode.light : ThemeMode.dark,
            );
          },
        );
      },
    );
  }
}