import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section3{
  Widget buildSlide(String url) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ), // Applies a dark filter to the image
        ),
      ),
    );
  }
  Widget buildCategoryCard(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
  Widget buildCategoryListView(List<Map<String, String>> categories, int selectedCategoryIndex, Function(int) onCategorySelected) {
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
              );
            } else {
              final category = categories[index - 1];
              return buildCategoryCard(
                '${category['icon']} ${category['name']}',
                selectedCategoryIndex == index,
                    () => onCategorySelected(index),
              );
            }
          },
        ),
      ),
    );
  }
}