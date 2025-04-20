import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_project/helper/validation.dart';
import 'package:foodtek_project/view/widgets/reset_password_successful_animation.dart';
import 'package:foodtek_project/view/widgets/spin_kit_hour_glass_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/user_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../helper/secure_storage_helper.dart';
import '../../../states/user_state.dart';
import '../../../theme/app_theme_extensions.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    required this.email,
    required this.otp,
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Validation validation = Validation();

  @override
  void initState() {
    super.initState();
    loadStoredData();
  }

  Future<void> loadStoredData() async {
    String storedEmail = await SecureStorageHelper.instance.getPrefString(
      key: "email",
      defaultValue: "",
    );
    String storedOtp = await SecureStorageHelper.instance.getPrefString(
      key: "otp",
      defaultValue: "",
    );

    setState(() {
      validation.emailTextEditingController.text = storedEmail;
      validation.otpTextEditingController.text = storedOtp;
    });
  }

  @override
  void dispose() {
    validation.emailTextEditingController.dispose();
    validation.otpTextEditingController.dispose();
    validation.newPasswordTextEditingController.dispose();
    validation.passwordConfirmationTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    return Scaffold(
      backgroundColor:theme.splashScreenColor,
      body: SafeArea(
        top: true,
        left: true,
        maintainBottomViewPadding: true,
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: ResetPasswordSuccessfulAnimation(),
                  ),
                ),
              );
            }
            if (state is ResetPasswordFailedState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            if (state is UserLoadingResetPassword) {
              return Center(child: SpinKitHourGlassWidget());
            }

            return Container(
              height: responsiveHeight(context, 932),
              width: responsiveWidth(context, 430),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash_screen.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: responsiveHeight(context, 74),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Foodtek',
                                style: GoogleFonts.protestRiot(
                                  fontSize: responsiveWidth(context, 80),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: 1.0,
                                  letterSpacing: 0.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: responsiveHeight(context, 201),
                      left: responsiveWidth(context, 43),
                      child: Container(
                        width: responsiveWidth(context, 343),
                        height: responsiveHeight(context, 417),
                        decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(
                            responsiveWidth(context, 12),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(responsiveWidth(context, 24)),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    width: responsiveWidth(context, 24),
                                    height: responsiveHeight(context, 24),
                                    child: SvgPicture.asset(
                                      'assets/images/Vector.svg',
                                      fit: BoxFit.none,
                                      colorFilter: ColorFilter.mode(
                                        theme.iconColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: responsiveHeight(context, 24)),

                                Container(
                                  width: responsiveWidth(context, 295),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.resetPassword,
                                        style: GoogleFonts.inter(
                                          fontSize: responsiveWidth(
                                            context,
                                            32,
                                          ),
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                          letterSpacing: -0.02,
                                          color: theme.textColorPrimary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: responsiveHeight(context, 12),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.wantToTryWithMyCurrentPassword,
                                            style: GoogleFonts.inter(
                                              fontSize: responsiveWidth(
                                                context,
                                                12,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              height: 1.4,
                                              letterSpacing: -0.01,
                                              color: theme.secondaryTextColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: responsiveWidth(context, 6),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          LoginScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.logIn,
                                              style: GoogleFonts.inter(
                                                fontSize: responsiveWidth(
                                                  context,
                                                  12,
                                                ),
                                                fontWeight: FontWeight.w600,
                                                height: 1.4,
                                                letterSpacing: -0.01,
                                                color: theme.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: responsiveHeight(context, 24)),

                                Container(
                                  width: responsiveWidth(context, 295),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.newPassword,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: theme.secondaryTextColor,
                                          fontSize: 12,
                                          letterSpacing: -0.02,
                                          height: 1.6,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        width: responsiveWidth(context, 295),
                                        height: responsiveHeight(context, 46),
                                        decoration: BoxDecoration(
                                          color: theme.containerColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: theme.borderColor,
                                            width: 1,
                                          ),
                                          boxShadow:  [
                                            BoxShadow(
                                              color: theme.shadowColor,
                                              offset: Offset(0, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:
                                              validation
                                                  .newPasswordTextEditingController,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            height: 1.4,
                                            letterSpacing: -0.01,
                                            color: theme.textFieldTextColor,
                                          ),
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(
                                                  context,
                                                )!.enterYourPassword,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: responsiveHeight(
                                                context,
                                                14,
                                              ),
                                              color: theme.hintTextColor,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: responsiveWidth(
                                                    context,
                                                    13,
                                                  ),
                                                  vertical: responsiveHeight(
                                                    context,
                                                    14,
                                                  ),
                                                ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: responsiveHeight(context, 16),
                                      ),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.confirmNewPassword,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: theme.secondaryTextColor,
                                          fontSize: 12,
                                          letterSpacing: -0.02,
                                          height: 1.6,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        width: responsiveWidth(context, 295),
                                        height: responsiveHeight(context, 46),
                                        decoration: BoxDecoration(
                                          color: theme.containerColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: theme.borderColor,
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: theme.shadowColor,
                                              offset: const Offset(0, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          controller:
                                              validation
                                                  .passwordConfirmationTextEditingController,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            height: 1.4,
                                            letterSpacing: -0.01,
                                            color: theme.textFieldTextColor,
                                          ),
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(
                                                  context,
                                                )!.reEnterYourPassword,
                                            hintStyle: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: responsiveHeight(
                                                context,
                                                14,
                                              ),
                                              color: theme.hintTextColor,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: responsiveWidth(
                                                    context,
                                                    13,
                                                  ),
                                                  vertical: responsiveHeight(
                                                    context,
                                                    14,
                                                  ),
                                                ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: responsiveHeight(context, 24),
                                      ),
                                      SizedBox(
                                        width: responsiveWidth(context, 295),
                                        height: responsiveHeight(context, 48),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            // print(
                                            //   "Email: ${validation.emailTextEditingController.text}, OTP: ${validation.otpTextEditingController.text}",
                                            // );
                                            //
                                            // print(
                                            //   "Email: ${validation.emailTextEditingController.text}",
                                            // );
                                            // print(
                                            //   "OTP: ${validation.otpTextEditingController.text}",
                                            // );
                                            // print(
                                            //   "New Password: ${validation.newPasswordTextEditingController.text}",
                                            // );
                                            // print(
                                            //   "Confirm Password: ${validation.passwordConfirmationTextEditingController.text}",
                                            // );
                                            final email =
                                                await SecureStorageHelper
                                                    .instance
                                                    .getPrefString(
                                                      key: "email",
                                                      defaultValue: "",
                                                    );
                                            final otp =
                                                await SecureStorageHelper
                                                    .instance
                                                    .getPrefString(
                                                      key: "otp",
                                                      defaultValue: "",
                                                    );

                                            if (email.isEmpty || otp.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "email and otp are missing",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                            if (validation
                                                .newPasswordTextEditingController
                                                .text
                                                .isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.pleaseEnterYourNewPassword,
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            if (validation
                                                    .newPasswordTextEditingController
                                                    .text !=
                                                validation
                                                    .passwordConfirmationTextEditingController
                                                    .text) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.passwordsDoesNotMatch,
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            context.read<UserCubit>().resetPassword(
                                              widget.email,
                                              widget.otp,
                                              validation
                                                  .newPasswordTextEditingController
                                                  .text,
                                              validation
                                                  .passwordConfirmationTextEditingController
                                                  .text,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: theme.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    responsiveWidth(
                                                      context,
                                                      10,
                                                    ),
                                                  ),
                                            ),
                                            elevation: 1,
                                            shadowColor: const Color.fromRGBO(
                                              37,
                                              62,
                                              167,
                                              0.48,
                                            ),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.updatePassword,
                                            style: GoogleFonts.inter(
                                              fontSize: responsiveWidth(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              color: theme.buttonTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget passwordInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isPassword = false,
    bool isObscured = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0XFF6C7278),
            letterSpacing: -0.02,
            height: 1.6,
          ),
        ),
        SizedBox(height: responsiveHeight(context, 2)),
        SizedBox(
          height: 46,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFEDF1F3), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3DE4E5E7),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 13),
                  vertical: responsiveHeight(context, 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
