import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtec/states/language_state.dart';
import 'package:foodtec/view/screens/home_cart/screen/home_screen.dart';
import 'package:foodtec/view/screens/home_cart/widget/bottom_nav_screen.dart';
import 'package:foodtec/view/screens/onboarding_screen/splash_screen.dart';
import 'cubits/language_cubit.dart';
import 'cubits/location_cubit.dart';
import 'cubits/orders_cubit.dart';
import 'cubits/user_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'gen_l10n/app_localizations.dart';
import 'my_bloc_observer.dart';
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => OrderCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          String languageCode = 'en';

          if (state is LanguageChangedSuccessfulState) {
            languageCode = state.locale.languageCode;
          }

          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'Foodtek',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('ar')],
            locale: Locale(languageCode),
            home: BottomNavScreen(),
          );
        },
      ),
    );
  }
}
