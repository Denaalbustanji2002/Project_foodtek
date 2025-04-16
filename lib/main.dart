// 1. في الملف الرئيسي (main.dart)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtec/states/ThemeState.dart';
import 'package:foodtec/states/language_state.dart';
import 'package:foodtec/view/screens/home_cart/widget/main_navbar.dart';

import 'cubits/ThemeCubit.dart';
import 'cubits/language_cubit.dart';
import 'cubits/location_cubit.dart';
import 'cubits/navigatiion_cubit.dart';
import 'cubits/orders_cubit.dart';
import 'cubits/user_cubit.dart';

import 'helper/shared_preferences_helper.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.instance.init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => NavigationCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  String languageCode = 'en';
                  if (languageState is LanguageChangedSuccessfulState) {
                    languageCode = languageState.locale.languageCode;
                  }

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Foodtek',
                    theme: themeState.lightTheme,
                    darkTheme: themeState.darkTheme,
                    themeMode: themeState.themeMode,
                    supportedLocales: const [Locale('en'), Locale('ar')],
                    locale: Locale(languageCode),
                    home: MainbarScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}