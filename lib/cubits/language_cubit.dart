import 'package:bloc/bloc.dart';
import 'dart:ui';
import '../helper/shared_preferences_helper.dart';
import '../states/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitialState(Locale('en')));

  Future<void> changeLang({required String langCode}) async {
    try {
      emit(LanguageLoadingState());

      await SharedPreferencesHelper.instance.savePrefString(
        key: 'lang',
        value: langCode,
      );
      emit(LanguageChangedSuccessfulState(Locale(langCode)));
    } catch (e) {
      emit(LanguageChangedFailedState(e.toString()));
    }
  }

  Future<void> getLang() async {
    String langCode = await SharedPreferencesHelper.instance.getPrefString(
      key: 'lang',
      defaultValue: 'en',
    );
    emit(LanguageInitialState(Locale(langCode)));
  }
}
