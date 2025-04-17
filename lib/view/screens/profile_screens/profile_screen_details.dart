import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import '../../../theme/app_theme_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreenDetails extends StatefulWidget {
  const ProfileScreenDetails({super.key});

  @override
  State<ProfileScreenDetails> createState() => _ProfileScreenDetailsState();
}

class _ProfileScreenDetailsState extends State<ProfileScreenDetails> {
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: 'Ahmad Daboor');
    _emailController = TextEditingController(text: 'ahmad1709@gmail.com');
    _phoneController = TextEditingController(text: '079765394');
    _passwordController = TextEditingController();
    _addressController = TextEditingController(text: '123 Al-Madina Street, Abdali,..');
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconColor),
          iconSize: responsiveHeight(context, 20),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 50,
        title: Text(
            AppLocalizations.of(context)!.profile,
           style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 20),
            fontWeight: FontWeight.w600,
            color: theme.titleColor,
            letterSpacing: 0.0,
            height: 1.0,
          ),
        ),
        titleSpacing: 0.0,
        leadingWidth: responsiveWidth(context, 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUserProfileHeader(context, theme),
            SizedBox(height: responsiveHeight(context, 20)),
            Center(
              child: Container(
                width: responsiveWidth(context, 380),
                height: responsiveHeight(context, 416),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.containerColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      blurRadius: 15,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInputField(
                      AppLocalizations.of(context)!.username,
                      _userNameController,
                      theme: theme,
                    ),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField(
                      AppLocalizations.of(context)!.email,
                      _emailController,
                      theme: theme,
                    ),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField(
                      AppLocalizations.of(context)!.phoneNumber,
                      _phoneController,
                      theme: theme,
                    ),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildPasswordField(
                      AppLocalizations.of(context)!.password,
                      theme,
                    ),
                    SizedBox(height: responsiveHeight(context, 9)),
                    _buildInputField(
                      AppLocalizations.of(context)!.address,
                      _addressController,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 50)),
            ElevatedButton(
              onPressed: () {
                // Function to update profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
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
                    colors: [theme.primaryColor, theme.primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -1,
                      height: 1.4,
                      color: theme.buttonTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label,
      TextEditingController controller, {
        required AppThemeExtension theme,
        int maxLines = 1,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: theme.labelTextColor,
            fontSize: responsiveHeight(context, 12),
            fontWeight: FontWeight.w500,
            height: 1.6,
            letterSpacing: -0.02,
          ),
        ),
        SizedBox(height: responsiveHeight(context, 2)),
        Container(
          width: responsiveWidth(context, 356),
          height: maxLines == 1 ? responsiveHeight(context, 46) : responsiveHeight(context, 70),
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: responsiveHeight(context, 14),
              color: theme.textFieldTextColor,
              height: 1.4,
              letterSpacing: -0.01,
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: responsiveHeight(context, 14),
                color: theme.hintTextColor,
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

  Widget _buildPasswordField(String label, AppThemeExtension theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: theme.labelTextColor,
            fontSize: responsiveHeight(context, 12),
            letterSpacing: -0.02,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: responsiveWidth(context, 356),
          height: responsiveHeight(context, 46),
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: TextField(
            obscureText: _obscurePassword,
            obscuringCharacter: '*',
            controller: _passwordController,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.01,
              color: theme.textFieldTextColor,
            ),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.enterYourPassword ?? 'أدخل كلمة المرور',
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: theme.hintTextColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 13),
                vertical: responsiveHeight(context, 14),
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: theme.iconColor.withOpacity(0.6),
                  size: 12,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfileHeader(BuildContext context, AppThemeExtension theme) {
    final brightness = Theme.of(context).brightness;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade200,
          child: Image.asset(
            "assets/images/profile_picture.png",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Ahmad Daboor',
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 16),
            fontWeight: FontWeight.w500,
            color: theme.titleColor,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'ahmad1709@gmail.com',
          style: GoogleFonts.inter(
            color: theme.labelTextColor,
            fontSize: responsiveHeight(context, 14),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}