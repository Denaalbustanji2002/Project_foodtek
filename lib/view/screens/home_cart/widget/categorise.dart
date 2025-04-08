import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, InkWell, MaterialPageRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/screen_index.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../../cubits/orders_cubit.dart';
import '../../../../states/orders_state.dart';
import '../screen/food_details.dart';

class CategoriesWidget extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoriesWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is OrderCategorySelected) {
            selectedIndex = state.selectedIndex;
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 22),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryName = '${category['icon'] ?? ''} ${category['name'] ?? ''}';

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    context.read<OrderCubit>().selectCategory(index);
                    context.read<NavigationCubit>().goTo(ScreenIndex.FoodInCateg);
                  },
                  child: buildCategoryCard(
                    categoryName,
                    category['icon'] ?? '',
                    selectedIndex == index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildCategoryCard(String text, String icon, bool isSelected) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
    color: isSelected ? Colors.green : Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: const Color(0XFF85DE9E)),),
    child: Text(
    text,
    style: TextStyle(
    color: isSelected ? Colors.white : Colors.black,
    fontWeight: FontWeight.bold,
    ),
    ),
    );
  }
}