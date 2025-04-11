import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodtek_project/helper/validation.dart';
import '../../../cubits/user_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/user_state.dart';
import '../../widgets/spin_kit_hour_glass_widget.dart';
import '../ordering_screens/home_screen.dart';
import '../authentication_screens/send_reset_link_forgot_password_screen.dart';
import '../authentication_screens/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Validation validation = Validation();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().readInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25AE4B),
      body: SafeArea(
        top: true,
        left: true,
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              print('========Navigating to OrderScreen...');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              });
            } else if (state is LoginFailedState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is GoogleSignInSuccessState) {
              String message = AppLocalizations.of(context)!
                  .loginSuccessful(state.userCredential.user?.displayName ?? "")
                  .replaceFirst(
                    "{displayName}",
                    state.userCredential.user?.displayName ?? "",
                  );

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            } else if (state is GoogleSignInFailedState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context)!.googleSignInFailed,
                    ),
                    content: Text(state.errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoadingLogin || state is UserLoadingGoogleSignIn) {
              return const SpinKitHourGlassWidget();
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
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: responsiveHeight(context, 201)),
                          Container(
                            width: responsiveWidth(context, 343),
                            height: responsiveHeight(context, 661),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  loginTextWidget(),
                                  const SizedBox(height: 16),
                                  emailInputField(
                                    AppLocalizations.of(
                                      context,
                                    )!.enterYourEmail,
                                  ),
                                  const SizedBox(height: 16),
                                  passwordInputField(
                                    AppLocalizations.of(
                                      context,
                                    )!.enterYourPassword,
                                    "*",
                                  ),
                                  const SizedBox(height: 16),
                                  buildRememberMeAndForgotPassword(),
                                  const SizedBox(height: 20),
                                  loginButton(),
                                  const SizedBox(height: 15),
                                  orDivider(),
                                  const SizedBox(height: 15),
                                  socialMediaButtons(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget loginTextWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.login,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.02,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.dontHaveAnAccount,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.01,
                height: 1.4,
                color: const Color(0XFF6C7278),
              ),
            ),
            const SizedBox(width: 6),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                AppLocalizations.of(context)!.signUp,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.01,
                  height: 1.4,
                  color: const Color(0XFF25AE4B),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget emailInputField(String? hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.email,
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6C7278),
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
            controller: validation.emailTextEditingController,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0XFF1A1C1E),
              height: 1.4,
              letterSpacing: -0.01,
            ),
            decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey[500],
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

  Widget passwordInputField(String? hintText, String obscuringCharacter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.password,
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF6C7278),
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
            obscureText: validation.obscureTextPassword,
            obscuringCharacter: obscuringCharacter,
            controller: validation.passwordTextEditingController,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.01,
              color: const Color(0xFF1A1C1E),
            ),
            decoration: InputDecoration(
              hintText:
                  hintText ?? AppLocalizations.of(context)!.enterYourPassword,
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey[500],
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
                  color: const Color(0XFFACB5BB),
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

  Widget buildRememberMeAndForgotPassword() {
    return Container(
      width: responsiveWidth(context, 295),
      height: responsiveHeight(context, 19),
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: responsiveWidth(context, 19),
                height: responsiveHeight(context, 19),
                child: Checkbox(
                  side: BorderSide(width: 1.5, color: const Color(0xFF6C7278)),
                  value: validation.rememberMe,
                  onChanged: (value) {
                    setState(() {
                      validation.rememberMe = value ?? false;
                    });
                    context.read<UserCubit>().saveInfo(
                      email: validation.emailTextEditingController.text,
                      password: validation.passwordTextEditingController.text,
                      remember: validation.rememberMe,
                    );
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.rememberMe,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 1.5,
                  letterSpacing: -0.01,
                  color: Color(0xFF6C7278),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const SendResetLinkForgotPasswordScreen(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 1.4,
                letterSpacing: -0.1,
                color: Color(0xFF25AE4B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: responsiveWidth(context, 295),
      height: responsiveHeight(context, 48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
      ),
      child: ElevatedButton(
        onPressed: () async {
          validation.checkEmail(
            email: validation.emailTextEditingController.text,
            isLogin: true,
          );
          validation.checkPassword(
            password: validation.passwordTextEditingController.text,
            isLogin: true,
          );

          if (!validation.showErrorEmail && !validation.showErrorPassword) {
            context.read<UserCubit>().saveInfo(
              email: validation.emailTextEditingController.text,
              password: validation.passwordTextEditingController.text,
              remember: true,
            );

            await context.read<UserCubit>().logIn(
              email: validation.emailTextEditingController.text,
              password: validation.passwordTextEditingController.text,
              remember: validation.rememberMe,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF25AE4B),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          AppLocalizations.of(context)!.login,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.01,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget orDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0XFFEDF1F3), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.5,
              letterSpacing: -0.12,
              color: Color(0XFF6C7278),
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0XFFEDF1F3), thickness: 1)),
      ],
    );
  }

  Widget socialMediaButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.read<UserCubit>().signInWithGoogle();
          },
          child: Container(
            width: responsiveWidth(context, 295),
            height: responsiveHeight(context, 48),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEFF0F6)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99F4F5FA),
                  offset: Offset(0, -3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: responsiveWidth(context, 18),
                  height: responsiveHeight(context, 18),
                  child: Image.asset('assets/images/google.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.continueWithGoogle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.4,
                    letterSpacing: -0.01,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: responsiveWidth(context, 295),
            height: responsiveHeight(context, 48),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEFF0F6)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99F4F5FA),
                  offset: Offset(0, -3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: responsiveWidth(context, 18),
                  height: responsiveHeight(context, 18),
                  child: Image.asset('assets/images/facebook.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.continueWithFacebook,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.4,
                    letterSpacing: -0.01,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: responsiveWidth(context, 295),
            height: responsiveHeight(context, 48),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEFF0F6)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99F4F5FA),
                  offset: Offset(0, -3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: responsiveWidth(context, 15),
                  height: responsiveHeight(context, 18.75),
                  child: Image.asset('assets/images/Apple.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.continueWithApple,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.4,
                    letterSpacing: -0.01,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
