import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/screen_index.dart';

class NavigationCubit extends Cubit<int> {
  int previousIndex = ScreenIndex.HomeScreen;
  List<int> _history = [ScreenIndex.HomeScreen];

  NavigationCubit() : super(ScreenIndex.HomeScreen);

  void goTo(int newIndex) {
    if (state != newIndex) {
      previousIndex = state;
      _history.add(newIndex);
      emit(newIndex);
    }
  }

  bool canPop() => _history.length > 1;

  void pop() {
    if (canPop()) {
      _history.removeLast();
      previousIndex = _history.length > 1 ? _history[_history.length - 2] : ScreenIndex.HomeScreen;
      emit(_history.last);
    }
  }

  // إضافة دالة للعودة إلى الشاشة الرئيسية
  void resetToHome() {
    _history = [ScreenIndex.HomeScreen];
    emit(ScreenIndex.HomeScreen);
  }
}