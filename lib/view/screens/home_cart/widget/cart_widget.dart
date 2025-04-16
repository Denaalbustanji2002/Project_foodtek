import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/ThemeCubit.dart';
import '../../../../states/ThemeState.dart';


class Section3 {
  Widget buildSlide(String url, BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {

        Color borderColor = state.themeMode == ThemeMode.dark
            ? Colors.white70
            : Colors.blueGrey;
        Color overlayColor = state.themeMode == ThemeMode.dark
            ? Colors.black.withOpacity(0.5)
            : Colors.black.withOpacity(0.3);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url),
              colorFilter: ColorFilter.mode(overlayColor, BlendMode.darken),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoryCard(String text, bool isSelected, VoidCallback onTap, BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {

        Color backgroundColor = isSelected
            ? Colors.green
            : state.themeMode == ThemeMode.dark
            ? Colors.grey[850]!
            : Colors.white;
        Color textColor = isSelected ? Colors.white : Colors.black;
        Color borderColor = state.themeMode == ThemeMode.dark
            ? Colors.white30
            : Color(0XFF85DE9E);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoryListView(List<Map<String, String>> categories, int selectedCategoryIndex, Function(int) onCategorySelected, BuildContext context) {
    return SizedBox(
      height: 43,
      child: Padding(
        padding: const EdgeInsets.only(left: 22),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildCategoryCard(
                'All',
                selectedCategoryIndex == 0,
                    () => onCategorySelected(0),
                context,
              );
            } else {
              final category = categories[index - 1];
              return buildCategoryCard(
                '${category['icon']} ${category['name']}',
                selectedCategoryIndex == index,
                    () => onCategorySelected(index),
                context,
              );
            }
          },
        ),
      ),
    );
  }
}
