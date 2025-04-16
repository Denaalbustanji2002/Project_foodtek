import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': '🍔', 'name': 'Burgers'},
    {'icon': '🍕', 'name': 'Pizza'},
    {'icon': '🍣', 'name': 'Sushi'},
    {'icon': '🍜', 'name': 'Noodles'},
    {'icon': '🍟', 'name': 'Fries'},
  ];

  final List<Map<String, dynamic>> products = [
    {'name': 'Pepperoni Pizza', 'price': 29, 'image': 'assets/pepperoni.png'},
    {'name': 'Pizza Cheese', 'price': 23, 'image': 'assets/cheese.png'},
    {'name': 'Peppy Paneer', 'price': 13, 'image': 'assets/paneer.png'},
    {'name': 'Mexican Green Wave', 'price': 23, 'image': 'assets/mexican.png'},
  ];

  void onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  Widget buildCategoryTab(String text, bool isSelected, VoidCallback onTap) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green
              : theme.cardColor, // adapts to light/dark mode
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF85DE9E)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white : Colors.black),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 43,
          child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                return buildCategoryTab(
                  index == 0
                      ? 'All'
                      : '${categories[index - 1]['icon']} ${categories[index - 1]['name']}',
                  selectedCategoryIndex == index,
                      () => onCategorySelected(index),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(products[index]['image'], height: 80),
                    const SizedBox(height: 8),
                    Text(
                      products[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      "\$${products[index]['price']}",
                      style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("Order Now"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
