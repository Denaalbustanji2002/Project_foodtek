import 'package:flutter_bloc/flutter_bloc.dart';
import '../view/widgets/app_tab.dart';

class NavigationCubit extends Cubit<AppTab> {
  NavigationCubit() : super(AppTab.home);

  void changeTab(AppTab tab) => emit(tab);

}
