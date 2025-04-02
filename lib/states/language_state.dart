import 'dart:ui';

abstract class LanguageState {}

class LanguageInitialState extends LanguageState {
  final Locale locale;
  LanguageInitialState(this.locale);
}

class LanguageLoadingState extends LanguageState {}

class LanguageChangedSuccessfulState extends LanguageState {
  final Locale locale;
  LanguageChangedSuccessfulState(this.locale);
}

class LanguageChangedFailedState extends LanguageState {
  final String errorMessage;
  LanguageChangedFailedState(this.errorMessage);
}