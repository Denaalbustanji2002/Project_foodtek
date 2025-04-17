import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodtek_project/states/language_state.dart';
import 'package:foodtek_project/states/theme_state.dart';
import 'package:foodtek_project/theme/app_theme_extensions.dart';
import 'package:foodtek_project/view/screens/authentication_screens/reset_password_screen.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/splash_screen.dart';
import 'cubits/favorite_cubit.dart';
import 'cubits/history_cubit.dart';
import 'cubits/language_cubit.dart';
import 'cubits/location_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'cubits/user_cubit.dart';
import 'helper/shared_preferences_helper.dart';
import 'my_bloc_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences first
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
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          String languageCode = 'en';

          if (languageState is LanguageChangedSuccessfulState) {
            languageCode = languageState.locale.languageCode;
          }

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Foodtek',
                theme: ThemeData(
                  extensions: [
                    AppThemeExtension.light, // ← استخدم الامتداد هنا
                  ],
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: Colors.white,
                  cardColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Color(0xFF391713)),
                    titleTextStyle: TextStyle(color: Color(0xFF391713)),
                  ),
                ),
                darkTheme: ThemeData(
                  extensions: [
                    AppThemeExtension.dark, // ← وهنا أيضاً
                  ],
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: const Color(0xFF121212),
                  cardColor: const Color(0xFF2D2D2D),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF121212),
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                themeMode: themeState == ThemeState.dark ? ThemeMode.dark : ThemeMode.light,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                locale: Locale(languageCode),
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
