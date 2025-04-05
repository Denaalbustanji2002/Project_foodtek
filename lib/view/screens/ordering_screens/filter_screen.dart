import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/header_widget.dart';
import '../profile_screens/profile_screen.dart';
import 'Cart_history_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRangeValues = RangeValues(0, 10);
  RangeValues _discountRangeValues = RangeValues(0, 50);
  String _selectedCategory = 'Sea Food';
  String _selectedDistance = '5 KM';
  List<String> _selectedDishes = ['Spicy Crab Cakes'];
  int currentIndex = 0;
  void onItemTapped(int index) {
    Widget nextScreen;

    switch (index) {
      case 0:
        nextScreen = HomeScreen();
        break;
      case 1:
        nextScreen = FavoritesScreen();
        break;
      case 3:
        nextScreen = CartHistoryScreen();
        break;
      case 4:
        nextScreen = ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );

    setState(() {
      currentIndex = index;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: responsiveHeight(context, 15)),
                    _buildSectionTitle('Filter'),
                    SizedBox(height: responsiveHeight(context, 32)),
                    _buildPriceRange(),
                    SizedBox(height: responsiveHeight(context, 32)),
                    _buildDiscount(),
                    SizedBox(height: responsiveHeight(context, 32)),
                    _buildCategory(),
                    SizedBox(height: responsiveHeight(context, 32)),
                    _buildLocation(),
                    SizedBox(height: responsiveHeight(context, 32)),
                    _buildDish(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: responsiveHeight(context, 20),
        fontWeight: FontWeight.w600,
        color: Color(0xFF391713),
        letterSpacing: 0.0,
        height: 1.0,
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: responsiveHeight(context, 14),
          color: Color(0xFF98A0B4),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 14 / 17,
        ),
      ),
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading('Price range'),
        Row(
          children: [
            Expanded(
              child: Container(
                height: responsiveHeight(context, 38),
                width: responsiveWidth(context, 181),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEAFAEB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Min',
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 14),
                    color: Color(0xFF4B4B4B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: responsiveWidth(context, 15)),
            Expanded(
              child: Container(
                height: responsiveHeight(context, 38),
                width: responsiveWidth(context, 181),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEAFAEB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Max',
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 14),
                    color: Color(0xFF4B4B4B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: responsiveHeight(context, 10)),
        Container(
          width: 378,
          height: 36,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$0',
                      style: const TextStyle(
                        color: Color(0xFF25AE4B),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),

                    Text(
                      '\$10B',
                      style: const TextStyle(
                        color: Color(0xFF25AE4B),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 6,
                    activeTrackColor: const Color(0xFF25AE4B),
                    inactiveTrackColor: const Color(
                      0xFF25AE4B,
                    ).withOpacity(0.2),
                    thumbColor: const Color(0xFF25AE4B),
                    overlayColor: const Color(0xFF25AE4B).withOpacity(0.1),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,

                    ),
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: RangeSlider(
                    values: _priceRangeValues,
                    min: 0,
                    max: 10,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRangeValues = values;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading('Discount'),
        Row(
          children: [
            Expanded(
              child: Container(
                height: responsiveHeight(context, 38),
                width: responsiveWidth(context, 181),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEAFAEB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Min',
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 14),
                    color: Color(0xFF4B4B4B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: responsiveHeight(context, 38),
                width: responsiveWidth(context, 181),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEAFAEB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Max',
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 14),
                    color: Color(0xFF4B4B4B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 378,
          height: 36,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$0',
                      style: const TextStyle(
                        color: Color(0xFF25AE4B),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      '\$50',
                      style: const TextStyle(
                        color: Color(0xFF25AE4B),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 6,
                    activeTrackColor: const Color(0xFF25AE4B),
                    inactiveTrackColor: const Color(0xFF25AE4B).withOpacity(0.2),
                    thumbColor: const Color(0xFF25AE4B),
                    overlayColor: const Color(0xFF25AE4B).withOpacity(0.1),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 3,
                    ),
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: RangeSlider(
                    values: _discountRangeValues,
                    min: 0,
                    max: 50,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _discountRangeValues = values;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading('Category'),
        Row(
          children: [
            _buildCategoryChip('Fast Food', 'Fast Food' == _selectedCategory),
            const SizedBox(width: 10),
            _buildCategoryChip('Sea Food', 'Sea Food' == _selectedCategory),
            const SizedBox(width: 10),
            _buildCategoryChip('Dessert', 'Dessert' == _selectedCategory),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF25AE4B) : Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            color: isSelected ? Color(0xFFFFFFFF) : Color(0xFF4B4B4B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading('Location'),
        Row(
          children: [
            _buildDistanceChip('1 KM', '1 KM' == _selectedDistance),
            const SizedBox(width: 10),
            _buildDistanceChip('5 KM', '5 KM' == _selectedDistance),
            const SizedBox(width: 10),
            _buildDistanceChip('10 KM', '10 KM' == _selectedDistance),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDistance = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF25AE4B) : Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            color: isSelected ? Color(0xFFFFFFFF) : Color(0xFF4B4B4B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDish() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading('Dish'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildDishChip(
              'Tuna Tartare',
              _selectedDishes.contains('Tuna Tartare'),
            ),
            _buildDishChip(
              'Spicy Crab Cakes',
              _selectedDishes.contains('Spicy Crab Cakes'),
            ),
            _buildDishChip(
              'Seafood Paella',
              _selectedDishes.contains('Seafood Paella'),
            ),
            _buildDishChip(
              'Clam Chowder',
              _selectedDishes.contains('Clam Chowder'),
            ),
            _buildDishChip(
              'Miso-Glazed Cod',
              _selectedDishes.contains('Miso-Glazed Cod'),
            ),
            _buildDishChip(
              'Lobster Thermidor',
              _selectedDishes.contains('Lobster Thermidor'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDishChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedDishes.remove(label);
          } else {
            _selectedDishes.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF25AE4B) : Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            color: isSelected ? Color(0xFFFFFFFF) : Color(0xFF4B4B4B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', false),
          _buildNavItem(Icons.favorite_border, 'Favorites', false),
          _buildCartButton(),
          _buildNavItem(Icons.history, 'History', false),
          _buildNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.green : Colors.grey, size: 24),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCartButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.shopping_cart, color: Colors.white),
    );
  }
  Widget _buildFloatingButton() {
    return FloatingActionButton(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartHistoryScreen()),
        );
      },
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
        size: responsiveHeight(context, 24),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: const Color(0xFFDBF4D1),
      child: Padding(
        padding: EdgeInsets.only(bottom: responsiveHeight(context, 10)),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: const Color(0XFF25AE4B),
          unselectedItemColor: const Color(0XFF484C52),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
