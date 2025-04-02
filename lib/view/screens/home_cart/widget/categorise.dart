import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, InkWell, MaterialPageRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      height:40, // You can adjust the height as needed
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is OrderCategorySelected) {
            selectedIndex = state.selectedIndex;
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryName = '${category['icon'] ?? ''} ${category['name'] ?? ''}';
// Safely access category name
              // Safely access category icon


              return Padding(

                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GestureDetector(
                  onTap: () {
                    // When a category is tapped, update the selected index and navigate to FoodDetails
                    context.read<OrderCubit>().selectCategory(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodDetails()),
                    );
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
    return GestureDetector(

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0XFF85DE9E)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

  }

}