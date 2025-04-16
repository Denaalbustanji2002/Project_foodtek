import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';


import '../../../cubits/language_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/language_state.dart';
import '../../widget/spin_kit_hour_glass_widget.dart';
import '../onboarding_screen/page_view_screen.dart';


class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 150),
            left: responsiveWidth(context, 120),
            child: Text(
              "Welcome",
              style: GoogleFonts.protestRiot(
                fontSize: responsiveHeight(context, 50),
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.0,
                letterSpacing: 0.0,
              ),
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 350),
            left: responsiveWidth(context, 100),
            child: Text(
              "Choose Your Language",
              style: GoogleFonts.protestRiot(
                fontSize: responsiveHeight(context, 25),
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.0,
                letterSpacing: 0.0,
              ),
            ),
          ),
          Center(
            child: BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                if (state is LanguageInitialState) {
                  return LanguagePickerDropdown(
                    initialValue: getLanguageCode(state.locale.languageCode),
                    languages: supportedLanguages,
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (language) {
                      context.read<LanguageCubit>().changeLang(langCode: language.isoCode);
                    },
                  );
                } else if (state is LanguageLoadingState) {
                  return SpinKitHourGlassWidget();
                } else if (state is LanguageChangedSuccessfulState) {
                  return LanguagePickerDropdown(
                    initialValue: getLanguageCode(state.locale.languageCode),
                    languages: supportedLanguages,
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (language) {
                      context.read<LanguageCubit>().changeLang(langCode: language.isoCode);
                    },
                  );
                } else if (state is LanguageChangedFailedState) {
                  return Center(child: Text('Changing language failed: ${state.errorMessage}'));
                }
                return Container();
              },
            ),
          ),
          Positioned(
            top: responsiveHeight(context, 600),
            left: responsiveWidth(context, 130),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageViewScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25AE4B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(responsiveWidth(context, 10)),
                ),
                elevation: 1,
                shadowColor: const Color.fromRGBO(37, 62, 167, 0.48),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: responsiveWidth(context, 14),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(width: 8.0),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  final List<Language> supportedLanguages = [
    Languages.english,
    Languages.arabic,
  ];
}

Language getLanguageCode(String languageCode) {
  switch (languageCode) {
    case 'en':
      return Languages.english;
    case 'ar':
      return Languages.arabic;
    default:
      return Languages.english;
  }
}