import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ColorScheme, Colors, InkWell, MaterialPageRoute, Theme, ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/screen_index.dart';
import '../../../../cubits/ThemeCubit.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../../cubits/orders_cubit.dart';
import '../../../../states/ThemeState.dart';
import '../../../../states/orders_state.dart';
import '../screen/food_details.dart';

class CategoriesWidget extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoriesWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is OrderCategorySelected) {
            selectedIndex = state.selectedIndex;
          }

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final isDarkMode = themeState.themeMode == ThemeMode.dark;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 22),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = '${category['icon'] ?? ''} ${category['name'] ?? ''}';

                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        context.read<OrderCubit>().selectCategory(index);
                        context.read<NavigationCubit>().goTo(ScreenIndex.FoodInCateg);
                      },
                      child: buildCategoryCard(
                        context,
                        categoryName,
                        category['icon'] ?? '',
                        selectedIndex == index,
                        isDarkMode,
                        colorScheme,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context,
      String text,
      String icon,
      bool isSelected,
      bool isDarkMode,
      ColorScheme colorScheme,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.green
            : isDarkMode
            ? colorScheme.surface
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : isDarkMode
              ? colorScheme.outline.withOpacity(0.5)
              : colorScheme.primary.withOpacity(0.5),
        ),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? colorScheme.onPrimary
              : colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}