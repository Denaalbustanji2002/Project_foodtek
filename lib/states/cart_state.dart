import '../models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> cartItems;
  CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String errorMsg;
  CartError(this.errorMsg);
}
