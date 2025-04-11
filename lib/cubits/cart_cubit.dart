import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/shared_preferences_helper.dart';
import '../models/cart_model.dart';
import '../states/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  static const String cartKey = 'cart_items';
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper.instance;

  List<CartModel> _cartItems = [];

  CartCubit() : super(CartInitial()) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final cartStringList =
      await _prefsHelper.getPrefStringList(key: cartKey, defaultValue: []);
      _cartItems = cartStringList
          .map((itemJson) => CartModel.fromJson(json.decode(itemJson)))
          .toList();

      emit(CartLoaded(List.from(_cartItems)));
    } catch (e) {
      emit(CartError('Failed Loading Cart'));
    }
  }

  Future<void> addToCart(CartModel product) async {
    emit(CartLoading());
    try {
      final index = _cartItems.indexWhere((item) => item.title == product.title);

      if (index != -1) {
        _cartItems[index].count += 1;
      } else {
        _cartItems.add(product);
      }

      await _saveCartToPrefs();
      emit(CartLoaded(List.from(_cartItems)));
    } catch (e) {
      emit(CartError('Failed Adding to cart'));
    }
  }

  Future<void> updateQuantity(String title, int newCount) async {
    emit(CartLoading());
    try {
      final index = _cartItems.indexWhere((item) => item.title == title);
      if (index != -1) {
        if (newCount <= 0) {
          _cartItems.removeAt(index);
        } else {
          _cartItems[index].count = newCount;
        }

        await _saveCartToPrefs();
        emit(CartLoaded(List.from(_cartItems)));
      }
    } catch (e) {
      emit(CartError('Failed Updating Quantity'));
    }
  }

  Future<void> deleteFromCart(String title) async {
    emit(CartLoading());
    try {
      _cartItems.removeWhere((item) => item.title == title);
      await _saveCartToPrefs();
      emit(CartLoaded(List.from(_cartItems)));
    } catch (e) {
      emit(CartError('Failed Deleting from cart'));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      _cartItems.clear();
      await _prefsHelper.savePrefStringList(key: cartKey, value: []);
      emit(CartLoaded([]));
    } catch (e) {
      emit(CartError('Failed Clearing Cart, Please try again later'));
    }
  }

  Future<void> _saveCartToPrefs() async {
    final cartStringList = _cartItems
        .map((item) => json.encode(item.toJson()))
        .toList();
    await _prefsHelper.savePrefStringList(key: cartKey, value: cartStringList);
  }
}
