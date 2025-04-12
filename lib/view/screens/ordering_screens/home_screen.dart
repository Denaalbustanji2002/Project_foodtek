import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:foodtek_project/view/widgets/Search_bar_widget.dart';
import 'package:foodtek_project/view/widgets/header_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../profile_screens/profile_screen.dart';
import 'Cart_history_screen.dart';
import 'favorites_screen.dart';
import 'food_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Pepperoni pizza',
      'description':
          'Pepperoni pizza, Margarita Pizza Margherita Italian cuisine Tomato',
      'price': '29.00',
      'image': 'assets/images/Photo Pizza.png',
      'rating': '4.5',
      'category': 'Pizza',
    },
    {
      'name': 'Pizza Cheese',
      'description':
          'Food pizza dish cuisine junk food, Fast Food, Flatbread, Ingredient',
      'price': '23.00',
      'image': 'assets/images/Photo Pizza.png',
      'rating': '4.2',
      'category': 'Pizza',
    },
    {
      'name': 'Peppy Paneer',
      'description': 'Chunky paneer with crisp capsicum and spicy red pepper',
      'price': '13.00',
      'image': 'assets/images/Photo Pizza.png',
      'rating': '4.0',
      'category': 'Pizza',
    },
    {
      'name': 'Mexican Green Wave',
      'description':
          'A pizza loaded with crunchy onions, crisp capsicum, juicy tomatoes',
      'price': '23.00',
      'image': 'assets/images/Photo Pizza.png',
      'rating': '4.3',
      'category': 'Pizza',
    },
    {
      'name': 'Chicken burger',
      'description': '100 gr chicken + tomato +cheese Lettuce',
      'price': '20.00',
      'image': 'assets/images/chicken_burger.png',
      'rating': '3.8',
      'category': 'Burger',
    },
    {
      'name': 'Cheese burger',
      'description': '100 gr meat+ onion+ tomato+ lettuce cheese',
      'price': '15.00',
      'image': 'assets/images/cheese_burger.png',
      'rating': '4.5',
      'category': 'Burger',
    },
    {
      'name': 'Ham Sandwich',
      'description': 'Fresh bread with ham, lettuce, and cheese',
      'price': '12.00',
      'image': 'assets/images/chicken_burger.png',
      'rating': '4.0',
      'category': 'Sandwich',
    },
    {
      'name': 'Club Sandwich',
      'description':
          'Triple decker sandwich with chicken, bacon, and fresh vegetables',
      'price': '18.00',
      'image': 'assets/images/chicken_burger.png',
      'rating': '4.2',
      'category': 'Sandwich',
    },
  ];

  final List<Map<String, dynamic>> recommendedItems = [
    {
      'name': 'Sushi',
      'price': '103.0',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/food%2Fsushi.jpg?alt=media&token=4bfc5003-88a5-4a0d-b465-e5638393d32e',
    },
    {
      'name': 'Salad',
      'price': '50.0',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/food%2Fsalad.jpg?alt=media&token=f8dc0bf7-e3e9-45f3-b318-334d9dc5b56b',
    },
    {
      'name': 'Pasta',
      'price': '12.99',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/food%2Fpasta.jpg?alt=media&token=9a62c18a-37a9-453c-abb1-a4c97c539096',
    },
    {
      'name': 'Cupcake',
      'price': '8.20',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/food%2Fcupcake.jpg?alt=media&token=55aa73f4-323b-4fb5-9871-51bca371c617',
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 'All') {
      return foodItems;
    } else {
      return foodItems
          .where((item) => item['category'] == selectedCategory)
          .toList();
    }
  }

  List<Map<String, dynamic>> favoriteItems = [];

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 20,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: HeaderWidget(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWidget(),
            SizedBox(height: responsiveHeight(context, 16)),
            _buildCategoryList(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedCategory == 'All')
                      Column(
                        children: [
                          _buildPromoBanner(),
                          _buildTopRatedSection(),
                          _buildRecommendedSection(),
                        ],
                      )
                    else
                      _buildFilteredFoodMenu(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      {'name': 'All', 'icon': null},
      {'name': 'Burger', 'icon': "🍔"},
      {'name': 'Pizza', 'icon': "🍕"},
      {'name': 'Sandwich', 'icon': "🌭"},
    ];

    return SizedBox(
      height: 43,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = categories[index]['name'] == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategory = categories[index]['name'] as String;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: isSelected ? Colors.white : Colors.black,
                backgroundColor:
                    isSelected ? const Color(0xFF25AE4B) : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side:
                      isSelected
                          ? BorderSide.none
                          : const BorderSide(color: Color(0xFFDBF4D1)),
                ),
                minimumSize:
                    isSelected ? const Size(49, 43) : const Size(126, 43),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (categories[index]['icon'] != null) ...[
                    Text(
                      categories[index]['icon'] as String,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        letterSpacing: -3,
                        color: Colors.black,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(width: responsiveWidth(context, 8)),
                  ],
                  Text(
                    categories[index]['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: responsiveHeight(context, 18),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.03,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.green,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Experience our\n delicious new dish',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Align(
                    child: Text(
                      '30% OFF',
                      style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/Photo Pizza.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilteredFoodMenu() {
    if (filteredItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No items found in this category',
            style: GoogleFonts.inter(
              fontSize: responsiveHeight(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: responsiveWidth(context, 16),
                mainAxisSpacing: responsiveHeight(context, 30),
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return _buildFoodItemCard(
                  name: item['name'],
                  description: item['description'],
                  rating: item['rating'],
                  price: item['price'],
                  imagePath: item['image'],
                );
              },
            ),
            SizedBox(height: responsiveHeight(context, 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRatedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: Text(
            'Top Rated',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF391713),
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildFoodItem(
                'Chicken burger',
                '100 gr chicken + tomato\n+cheese Lettuce',
                '3.8',
                '20.00',
                'assets/images/chicken_burger.png',
              ),
              _buildFoodItem(
                'Cheese burger',
                '100 gr meat+ onion+ tomato+ lettuce cheese',
                '4.5',
                '15.00',
                'assets/images/cheese_burger.png',
              ),
              _buildFoodItem(
                'Chicken burger',
                '100 gr meat +onion +tomato +lettuce cheese',
                '3.8',
                '20.00',
                'assets/images/chicken_burger.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommend',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF391713),
                  letterSpacing: -0.03,
                  height: 1.0,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Color(0xFF25AE4B),
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF25AE4B),
                      size: 12.99,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 108,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recommendedItems.length,
            itemBuilder: (context, index) {
              final item = recommendedItems[index];
              return Container(
                width: 72,
                margin: const EdgeInsets.only(right: 27.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.12),
                  color: Colors.black,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(19.12),
                      child: Image.network(item['image']!, fit: BoxFit.cover),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 11,
                        width: 34,
                        decoration: BoxDecoration(
                          color: Color(0xFF25AE4B),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '\$${item['price']}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                              letterSpacing: -0.03,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildFoodItem(
      String name,
      String description,
      String rating,
      String price,
      String imagePath,
      ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(name: '/foodDetails'),
            builder: (_) => FoodDetailScreen(
              name: name,
              description: description,
              rating: rating,
              price: price,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        width: 155,
        height: 209,
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFDBF4D1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(rating),
                ],
              ),
            ),
            Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
            Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF0D0D0D),
                  height: 1.0,
                  letterSpacing: -0.03,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Color(0xFF3B3B3B),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ $price',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF25AE4B),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFoodItemCard({
    required String name,
    required String description,
    required String price,
    required String imagePath,
    required String rating,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: responsiveWidth(context, 177),
          height: responsiveHeight(context, 252),
          margin: EdgeInsets.only(top: 44.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Color(0xFFDBF4D1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600,
                        fontSize: responsiveHeight(context, 14),
                        height: 15 / 14,
                        letterSpacing: 0.0,
                        color: Color(0xFF24262F),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: responsiveHeight(context, 8)),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w300,
                        fontSize: responsiveHeight(context, 10),
                        height: 12 / 10,
                        color: Color(0xFF969AB0),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: responsiveHeight(context, 12)),
                    Text(
                      '\$$price',
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600,
                        fontSize: responsiveHeight(context, 14),
                        height: 15 / 14,
                        color: Color(0xFF24262F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsiveHeight(context, 30)),
            ],
          ),
        ),

        Positioned(
          bottom: responsiveHeight(context, -10.5),
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: responsiveWidth(context, 95),
              height: responsiveHeight(context, 27),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF25AE4B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Order Now',
                  style: GoogleFonts.sora(
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 10),
                    height: 15 / 10,
                    letterSpacing: 0.0,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: responsiveHeight(context, 30),
          right: responsiveWidth(context, -5),
          child: GestureDetector(
            onTap: () {
              toggleFavorite({
                'name': name,
                'description': description,
                'price': price,
                'imagePath': imagePath,
                'rating': rating,
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDBF4D1),
                border: Border.all(color: Color(0xFFDBF4D1), width: 2),
              ),
              width: responsiveWidth(context, 35),
              height: responsiveHeight(context, 35),
              child: Icon(
                favoriteItems.any((item) => item['name'] == name)
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color:
                    favoriteItems.any((item) => item['name'] == name)
                        ? Colors.red
                        : Color(0xFF222628),
                size: responsiveHeight(context, 13),
              ),
            ),
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: responsiveWidth(context, 89),
              height: responsiveHeight(context, 89),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: responsiveWidth(context, 89),
                      height: responsiveHeight(context, 89),
                      foregroundDecoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Colors.transparent, Color(0x20818181)],
                          stops: [0.85, 1.0],
                          center: Alignment(0, -0.2),
                        ),
                      ),
                      // Second shadow effect
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x40767676),
                            Colors.transparent,
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.3, 1.0],
                        ),
                      ),
                    ),
                  ),

                  ClipOval(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fill,
                      width: responsiveWidth(context, 74),
                      height: responsiveHeight(context, 74),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}