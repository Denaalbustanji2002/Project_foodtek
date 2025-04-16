import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/screen_index.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../widget/custom_app_bar.dart';
import 'favorites_screen.dart';
import 'order_home.dart';

class FoodInCateg extends StatefulWidget {
  const FoodInCateg({super.key});

  @override
  State<FoodInCateg> createState() => _FoodInCategState();
}

class _FoodInCategState extends State<FoodInCateg> {
  int selectedCategoryIndex = 0;
  List<bool> isFavoriteList = List.generate(10, (index) => false);
  List<Map<String, dynamic>> favoriteItems = [];

  final List<Map<String, dynamic>> foodItems = [
    {
      'title': 'Peppy Paneer',
      'description': 'Chunky paneer with crisp capsicum and spicy red pepper',
      'price': '\$13',
      'image': 'assets/images/Order food-pana.png',
      'category': 'Pizza',
    },
    {
      'title': 'Veg Supreme',
      'description': 'A blend of fresh vegetables with cheese',
      'price': '\$12',
      'image': 'assets/images/Order food-pana.png',
      'category': 'Pizza',
    },
    {
      'title': 'Veg Supreme',
      'description': 'A blend of fresh vegetables with cheese',
      'price': '\$12',
      'image': 'assets/images/Order food-pana.png',
      'category': 'Burgers',
    },
    {
      'title': 'Veg Supreme',
      'description': 'A blend of fresh vegetables with cheese',
      'price': '\$12',
      'image': 'assets/images/Order food-pana.png',
      'category': 'Fries',
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': '🍔', 'name': 'Burgers'},
    {'icon': '🍕', 'name': 'Pizza'},
    {'icon': '🍣', 'name': 'Sushi'},
    {'icon': '🍜', 'name': 'Noodles'},
    {'icon': '🍟', 'name': 'Fries'},
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategoryIndex == 0) return foodItems;
    final category = categories[selectedCategoryIndex - 1]['name'];
    return foodItems.where((item) => item['category'] == category).toList();
  }

  Widget buildCategoryCard(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildFoodGrid(List<Map<String, dynamic>> items) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 18,
          childAspectRatio: 0.7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildFoodCard(items[index], index);
        },
      ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80, width: 105),
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['description'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          fontSize: 12
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['price'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        context.read<NavigationCubit>().goTo(ScreenIndex.OrderHome);
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).cardColor,
                  backgroundImage: AssetImage(item['image']),
                ),
              ),
              Positioned(
                top: -22,
                right: -10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.2),
                          blurRadius: 4
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavoriteList[index] ? Icons.favorite : Icons.favorite_border,
                      color: isFavoriteList[index] ? Colors.red : Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavoriteList[index] = !isFavoriteList[index];
                        if (isFavoriteList[index]) {
                          favoriteItems.add(item);
                        } else {
                          favoriteItems.removeWhere(
                                (favItem) => favItem['title'] == item['title'],
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 43,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length + 1,
                itemBuilder: (context, index) {
                  return buildCategoryCard(
                    index == 0
                        ? 'All'
                        : '${categories[index - 1]['icon']} ${categories[index - 1]['name']}',
                    selectedCategoryIndex == index,
                        () => setState(() => selectedCategoryIndex = index),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(child: buildFoodGrid(filteredItems)),
        ],
      ),
    );
  }}
