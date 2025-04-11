import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../cubits/user_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../helper/validation.dart';
import '../../../states/user_state.dart';
import '../../widgets/spin_kit_hour_glass_widget.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Validation validation = Validation();

  @override
  void initState() {
    super.initState();
    validation.errorListener();
  }

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();

    return Scaffold(
      backgroundColor: const Color(0XFF25AE4B),
      body: SafeArea(
        top: true,
        left: true,
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
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
                    constraints: BoxConstraints(
                      maxHeight: responsiveHeight(context, 661),
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: responsiveWidth(context, 24),
                                height: responsiveHeight(context, 24),
                                child: SvgPicture.asset(
                                  'assets/images/Vector.svg',
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.signUp,
                            style: GoogleFonts.inter(
                              color: Color(0XFF111827),
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.02,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.alreadyHaveAnAccount,
                                style: GoogleFonts.inter(
                                  color: Color(0XFF6C7278),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.01,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.logIn,
                                  style: GoogleFonts.inter(
                                    color: Color(0XFF25AE4B),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    letterSpacing: -0.01,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          BlocConsumer<UserCubit, UserState>(
                            listener: (context, state) {
                              if (state is SignUpSuccessState) {
                                print(
                                  "User signed up successfully, navigating to OrderScreen",
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              } else if (state is SignUpFailedState) {
                                print(
                                  "SignUp failed with error message: ${state.errorMessage}",
                                );
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.error,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      state.errorMessage,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(context),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.ok,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is UserLoadingSignUp) {
                                return SpinKitHourGlassWidget();
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    nameAndEmailAndPasswordInputField(
                                      label:
                                      AppLocalizations.of(
                                        context,
                                      )!.fullName,
                                      hintText:
                                      AppLocalizations.of(
                                        context,
                                      )!.enterYourFullName,
                                      controller:
                                      validation
                                          .fullNameTextEditingController,
                                      errorText:
                                      validation.showErrorFullName
                                          ? AppLocalizations.of(
                                        context,
                                      )!.fullNameCanNotBeEmpty
                                          : null,
                                    ),
                                    SizedBox(height: 8),
                                    nameAndEmailAndPasswordInputField(
                                      label:
                                      AppLocalizations.of(context)!.email,
                                      hintText:
                                      AppLocalizations.of(
                                        context,
                                      )!.enterYourEmail,
                                      controller:
                                      validation.emailTextEditingController,
                                      errorText:
                                      validation.showErrorEmail
                                          ? AppLocalizations.of(
                                        context,
                                      )!.pleaseEnterValidEmail
                                          : null,
                                    ),
                                    SizedBox(height: 8),
                                    dateInputField(context),
                                    SizedBox(height: 8),
                                    phoneInputField(),
                                    SizedBox(height: 8),
                                    nameAndEmailAndPasswordInputField(
                                      label:
                                      AppLocalizations.of(
                                        context,
                                      )!.setPassword,
                                      hintText:
                                      AppLocalizations.of(
                                        context,
                                      )!.enterYourPassword,
                                      controller:
                                      validation
                                          .passwordTextEditingController,
                                      isPassword: true,
                                      errorText:
                                      validation.showErrorPassword
                                          ? AppLocalizations.of(
                                        context,
                                      )!.passwordDoesNotMeetCriteria
                                          : null,
                                      obscuringCharacter: '*',
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  validation.checkFullName(
                                    fullName:
                                    validation
                                        .fullNameTextEditingController
                                        .text,
                                  );
                                  validation.checkEmail(
                                    email:
                                    validation
                                        .emailTextEditingController
                                        .text,
                                  );
                                  validation.checkPhone(
                                    phone:
                                    validation
                                        .phoneTextEditingController
                                        .text,
                                  );
                                  validation.checkPassword(
                                    password:
                                    validation
                                        .passwordTextEditingController
                                        .text,
                                  );
                                  validation.checkBirthDate();

                                  if (!validation.showErrorFullName &&
                                      !validation.showErrorEmail &&
                                      !validation.showErrorPhone &&
                                      !validation.showErrorPassword &&
                                      !validation.showErrorBirthDate) {
                                    await userCubit.saveInfo(
                                      email:
                                      validation
                                          .emailTextEditingController
                                          .text,
                                      password:
                                      validation
                                          .passwordTextEditingController
                                          .text,
                                      remember: true,
                                    );

                                    await userCubit.signUp(
                                      fullName:
                                      validation
                                          .fullNameTextEditingController
                                          .text,
                                      email:
                                      validation
                                          .emailTextEditingController
                                          .text,
                                      password:
                                      validation
                                          .passwordTextEditingController
                                          .text,
                                      phoneNumber:
                                      validation
                                          .phoneTextEditingController
                                          .text,
                                      dateOfBirth:
                                      validation
                                          .birthOfDateTextEditingController
                                          .text,
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
                                  AppLocalizations.of(context)!.register,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),)
    );
  }

  Widget nameAndEmailAndPasswordInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    String? errorText,
    bool isPassword = false,
    String? obscuringCharacter,
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
          child: TextField(
            controller: controller,
            obscuringCharacter: "*",
            obscureText: isPassword ? validation.obscureTextPassword : false,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey[500],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              suffixIcon:
                  isPassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            validation.obscureTextPassword =
                                !validation.obscureTextPassword;
                          });
                        },
                        icon: Icon(
                          validation.obscureTextPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0XFFACB5BB),
                          size: 12,
                        ),
                      )
                      : null,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ),
      ],
    );
  }

  Widget dateInputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.birthOfDate,
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
          child: TextField(
            controller: validation.birthOfDateTextEditingController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey[500],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              suffixIcon: const Icon(Icons.calendar_today, size: 20),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  validation.birthOfDateTextEditingController.text =
                      "${pickedDate.day.toString().padLeft(2, '0')}/"
                      "${pickedDate.month.toString().padLeft(2, '0')}/"
                      "${pickedDate.year}";
                  validation.showErrorBirthDate = false;
                });
              }
            },
          ),
        ),
        if (validation.showErrorBirthDate)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              AppLocalizations.of(context)!.invalidDateOfBirth,
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ),
      ],
    );
  }

  Widget phoneInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.phoneNumber,
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
          child: IntlPhoneField(
            controller: validation.phoneTextEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            initialCountryCode: 'US',
            disableLengthCheck: true,
            dropdownIconPosition: IconPosition.trailing,
            flagsButtonPadding: EdgeInsets.zero,
            showDropdownIcon: false,
            onChanged: (PhoneNumber phone) {
              validation.checkPhone(phone: phone.number);
              setState(() {});
            },
            onCountryChanged: (country) {
              setState(() {
                validation.checkPhone(
                  phone: validation.phoneTextEditingController.text,
                );
              });
            },
          ),
        ),
        if (validation.showErrorPhone)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              validation.phoneErrorText ?? '',
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            AppLocalizations.of(context)!.phoneErrorMessage,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
