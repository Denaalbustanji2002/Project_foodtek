abstract class OrderState {}
class OrderInitial extends OrderState {}

class GetBannerLoadingState extends OrderState {}
class GetBannerSuccessState extends OrderState {}
class GetBannerFailureState extends OrderState {}
class GetCategoriesSuccessState extends OrderState {}
class GetCategoriesFailureState extends OrderState {}
class OrderCategorySelected extends OrderState {
  final int selectedIndex;
  OrderCategorySelected(this.selectedIndex);
}