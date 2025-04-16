import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/profile_screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/validation.dart';
import '../../../gen_l10n/app_localizations.dart';
import '../../../helper/responsive.dart';
import '../add_to_cart/screen/history_screen.dart';

class ProfileScreenDetails extends StatefulWidget {
  @override
  _ProfileScreenDetailsState createState() => _ProfileScreenDetailsState();
}

class _ProfileScreenDetailsState extends State<ProfileScreenDetails> {
  final TextEditingController userNameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController addressTextEditingController = TextEditingController();
  Validation validation = Validation();

  @override
  void initState() {
    super.initState();
    userNameTextEditingController.text = 'Ahmad Daboor';
    emailTextEditingController.text = 'Loisbecket@gmail.com';
    phoneTextEditingController.text = '079765394';
    addressTextEditingController.text = '123 Al-Madina Street, Abdali,..';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
          ),
        ),
        titleSpacing: 0.0,
        leadingWidth: responsiveWidth(context, 40),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUserProfileHeader(context),
            SizedBox(height: responsiveHeight(context, 20)),
            Center(
              child: Container(
                width: responsiveWidth(context, 380),
                height: responsiveHeight(context, 416),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? colorScheme.outline.withOpacity(0.3) : Color(0xFFF5F5F5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Color(0x1F000000),
                      blurRadius: 15,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInputField('Username', userNameTextEditingController),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField('Email', emailTextEditingController),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField('Phone Number', phoneTextEditingController),
                    SizedBox(height: responsiveHeight(context, 9)),
                    passwordInputField('Password', '*', obscureText: true),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField('Address', addressTextEditingController, maxLines: 2),
                  ],
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 50)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Container(
                width: responsiveWidth(context, 295),
                height: responsiveHeight(context, 48),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green,Colors.green,],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.transparent : Color(0xFFFFFFFF),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -1,
                      height: 1.4,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool obscureText = false, int maxLines = 1}) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: responsiveHeight(context, 12),
            fontWeight: FontWeight.w500,
            height: 1.6,
            letterSpacing: -0.02,
          ),
        ),
        SizedBox(height: responsiveHeight(context, 2)),
        Container(
          width: responsiveWidth(context, 356),
          height: responsiveHeight(context, 46),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDarkMode ? colorScheme.outline.withOpacity(0.3) : Color(0xFFEDF1F3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.transparent : Color(0x3DE4E5E7),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: responsiveHeight(context, 14),
              color: colorScheme.onSurface,
              height: 1.4,
              letterSpacing: -0.01,
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: responsiveHeight(context, 14),
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 13),
                vertical: responsiveHeight(context, 14),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordInputField(String? hintText, String obscuringCharacter,
      {required bool obscureText}) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "password",
          style: GoogleFonts.plusJakartaSans(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: responsiveHeight(context, 12),
            letterSpacing: -0.02,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2),
        Container(
          width: responsiveWidth(context, 356),
          height: responsiveHeight(context, 46),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDarkMode ? colorScheme.outline.withOpacity(0.3) : Color(0xFFEDF1F3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.transparent : Color(0x3DE4E5E7),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: TextField(
            obscureText: validation.obscureTextPassword,
            obscuringCharacter: obscuringCharacter,
            controller: validation.passwordTextEditingController,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.01,
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: hintText ?? AppLocalizations.of(context)!.enterYourPassword,
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 13),
                vertical: responsiveHeight(context, 14),
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  validation.obscureTextPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: colorScheme.onSurface.withOpacity(0.5),
                  size: 12,
                ),
                onPressed: () {
                  setState(() {
                    validation.changeObscureTextPassword();
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfileHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
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
        Text(
          'Ahmad Daboor',
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 16),
            fontWeight: FontWeight.w500,
            color: colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'ahmad1709@gmail.com',
          style: GoogleFonts.inter(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontSize: responsiveHeight(context, 14),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}