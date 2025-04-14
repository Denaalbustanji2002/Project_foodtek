import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodtek_project/helper/validation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/user_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/user_state.dart';
import '../../widgets/spin_kit_hour_glass_widget.dart';
import '../../widgets/verification_code_widget.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendResetLinkForgotPasswordScreen extends StatefulWidget {
  const SendResetLinkForgotPasswordScreen({super.key});

  @override
  State<SendResetLinkForgotPasswordScreen> createState() =>
      _SendVerificationCodeScreenState();
}

class _SendVerificationCodeScreenState
    extends State<SendResetLinkForgotPasswordScreen> {
  Validation validation = Validation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF25AE4B),
        body: SafeArea(
          top: true,
          left: true,
          child: Container(
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
                children: [foodTekLogo(), resetPasswordCard()],
              ),
            ),
          ),)
    );
  }

  Widget foodTekLogo() {
    return Positioned(
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
    );
  }

  Widget resetPasswordCard() {
    return Positioned(
      top: responsiveHeight(context, 311),
      left: responsiveWidth(context, 43),
      child: Container(
        width: responsiveWidth(context, 343),
        height: responsiveHeight(context, 366.3),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backToLoginRow(),
            SizedBox(height: responsiveHeight(context, 24)),
            resetPasswordTitleAndDescription(),
            SizedBox(height: responsiveHeight(context, 24)),
            emailInputField(AppLocalizations.of(context)!.enterYourEmail),
            SizedBox(height: responsiveHeight(context, 16)),
            sendButton(),
          ],
        ),
      ),
    );
  }

  Widget backToLoginRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: SizedBox(
            width: responsiveWidth(context, 14),
            height: responsiveHeight(context, 8),
            child: SvgPicture.asset(
              'assets/images/Vector.svg',
              fit: BoxFit.fill,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: responsiveWidth(context, 6)),
        Text(
          AppLocalizations.of(context)!.backToLoginPage,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            color: const Color(0xFF6C7278),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.01,
            height: 1.4,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.logIn,
            style: GoogleFonts.inter(
              fontSize: responsiveHeight(context, 12),
              color: const Color(0xFF25AE4B),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.01,
              height: 1.4,
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.page,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            color: const Color(0xFF6C7278),
            fontWeight: FontWeight.w500,
            letterSpacing: -0.01,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget resetPasswordTitleAndDescription() {
    return SizedBox(
      width: responsiveWidth(context, 295),
      height: responsiveHeight(context, 105),
      child: Column(
        children: [
          SizedBox(
            width: responsiveWidth(context, 224),
            height: responsiveHeight(context, 42),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppLocalizations.of(context)!.resetPassword,
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 32),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                  letterSpacing: -0.02,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: responsiveHeight(context, 12)),
          SizedBox(
            width: responsiveWidth(context, 295),
            height: responsiveHeight(context, 51),
            child: Text(
              AppLocalizations.of(context)!.enterYourEmailOrPhone,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(context, 12),
                color: const Color(0xFF6C7278),
                fontWeight: FontWeight.w500,
                letterSpacing: -0.01,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailInputField(String? hintText) {
    return SizedBox(
      width: responsiveWidth(context, 295),
      height: responsiveHeight(context, 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.email,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6C7278),
              fontSize: responsiveHeight(context, 12),
              letterSpacing: -0.02,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: responsiveHeight(context, 2)),
          Container(
            width: responsiveWidth(context, 295),
            height: responsiveHeight(context, 46),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3DE4E5E7),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: TextField(
              controller: validation.emailTextEditingController,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: responsiveHeight(context, 14),
                color: const Color(0XFF1A1C1E),
                height: 1.4,
                letterSpacing: -0.01,
              ),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: hintText ?? '',
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: responsiveHeight(context, 14),
                  color: Colors.grey[500],
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 10),
                  vertical: responsiveHeight(context, 15),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sendButton() {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccessState) {

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: responsiveWidth(context, 343),
                  height: responsiveHeight(context, 389),
                  child: VerificationCodeWidget(email:validation.emailTextEditingController.text),
                ),
              );
            },
          );
        } else if (state is ForgotPasswordFailedState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is ForgotPasswordLoadingState) {
          return const Center(child: SpinKitHourGlassWidget());
        }
        return Container(
          width: responsiveWidth(context, 295),
          height: responsiveHeight(context, 48),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x1EFFFFFF), Color(0x00FFFFFF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x7A253EA7),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Color(0xFF85DE9E),
                offset: Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (validation.emailTextEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.pleaseEnterYourEmail,
                    ),
                  ),
                );
                return;
              }

              validation.checkEmail(
                email: validation.emailTextEditingController.text,
              );

              if (!validation.showErrorEmail) {
                final userCubit = context.read<UserCubit>();

                await userCubit.forgotPasswordResetLink(
                  validation.emailTextEditingController.text.trim(),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.pleaseEnterValidEmail,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF32B768),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.send,
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(context, 14),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.01,
                height: 1.4,
              ),
            ),
          ),
        );
      },
    );
  }
}