import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../core/const_values.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../states/orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  List<BannerModel> banners = [];
void getBannersData() async {
  http.Response response = await http.get(
      Uri.parse('${ConstValues.baseUrl}/banners'),

    );
  final  responseBody  = jsonDecode(response.body);
  if (responseBody['StatusCode'] == true) {
    for( var item in responseBody['data']){
      banners.add(BannerModel.fromJson(data: item));
    }emit(GetBannerSuccessState());
    } else {
    emit(GetBannerFailureState());

  }

}
  List<CategoryModel> categories = [];
  void getCategoriesData() async {
    http.Response response = await http.get(
      Uri.parse('${ConstValues.baseUrl}/categories'),

    );
    final  responseBody  = jsonDecode(response.body);
    if (responseBody['StatusCode'] == true) {
      for( var item in responseBody['data']['data']){
        categories.add(CategoryModel.fromJson(data: item));
      }emit(GetCategoriesSuccessState());
    } else {
      emit(GetCategoriesFailureState());

    }

  }

  void selectCategory(int index) {
    emit(OrderCategorySelected(index)); // إرسال الحالة الجديدة
  }

}