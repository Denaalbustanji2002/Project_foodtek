import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/shared_preferences_helper.dart';
import '../states/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  static const String _favKey = 'favorite_items';

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    final favorites = await SharedPreferencesHelper.instance.getPrefStringList(
      key: _favKey,
      defaultValue: [],
    );
    await Future.delayed(Duration(seconds: 1));
    emit(FavoriteLoaded(favorites));
  }

  Future<void> addFavorite(String item) async {
    final favorites = await SharedPreferencesHelper.instance.getPrefStringList(
      key: _favKey,
      defaultValue: [],
    );

    if (!favorites.contains(item)) {
      emit(FavoriteLoading());
      favorites.add(item);
      await SharedPreferencesHelper.instance.savePrefStringList(
        key: _favKey,
        value: favorites,
      );
      await Future.delayed(Duration(milliseconds: 500));
      emit(FavoriteLoaded(favorites));
    }
  }

  Future<void> removeFavorite(String item) async {
    final favorites = await SharedPreferencesHelper.instance.getPrefStringList(
      key: _favKey,
      defaultValue: [],
    );

    if (favorites.contains(item)) {
      emit(FavoriteLoading());
      favorites.remove(item);
      await SharedPreferencesHelper.instance.savePrefStringList(
        key: _favKey,
        value: favorites,
      );
      await Future.delayed(Duration(milliseconds: 500));
      emit(FavoriteLoaded(favorites));
    }
  }
}