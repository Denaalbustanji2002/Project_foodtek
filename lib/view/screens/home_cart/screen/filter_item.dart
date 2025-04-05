import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';




class FilterItem extends StatefulWidget {
  const FilterItem({super.key});

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  RangeValues _priceRange = const RangeValues(0, 10000000000);
  RangeValues _discountRange = const RangeValues(0, 50);
  Set<String> _selectedCategories = {};
  String? _selectedLocation;
  Set<String> _selectedDishes = {};

  final List<String> _categories = ['Fast Food', 'Sea Food', 'Dessert'];
  final List<String> _locations = ['1 KM', '5 KM', '10 KM'];
  final List<String> _dishes = [
    'Tuna Tartare',
    'Spicy Crab Cakes',
    'Seafood Paella',
    'Clam Chowder',
    'Miso-Glazed Cod',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar2(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        color: const Color(0xFF391713),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Divider(height: 18, thickness: 1, color: Color(0xFFF2F4F7)),
                  _buildPriceRangeSection(),
                  const Divider(height: 20, thickness: 1, color: Color(0xFFF2F4F7)),
                  _buildDiscountSection(),
                  const Divider(height: 20, thickness: 1, color: Color(0xFFF2F4F7)),
                  _buildCategorySection(),
                  const Divider(height: 20, thickness: 1, color: Color(0xFFF2F4F7)),
                  _buildLocationSection(),
                  const Divider(height: 20, thickness: 1, color: Color(0xFFF2F4F7)),
                  _buildDishSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),

    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price range',
          style: TextStyle(
            color: Color(0xFF98A0B4),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildRangeField('Min'),
            const SizedBox(width: 16),
            _buildRangeField('Max'),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            SizedBox(width: 15),
            Text('\$0', style: TextStyle(color: Color(0xFF25AE4B))),
            SizedBox(width: 290),
            Text('\$10B', style: TextStyle(color: Color(0xFF25AE4B))),
          ],
        ),
        const SizedBox(height: 4),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 10000000000,
          divisions: 10,
          labels: RangeLabels(
            '\$${_priceRange.start.toInt()}',
            '\$${_priceRange.end.toInt()}',
          ),
          activeColor: const Color(0xFF25AE4B),
          inactiveColor: const Color(0xFFF5F5F5),
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDiscountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discount',
          style: TextStyle(
            color: Color(0xFF98A0B4),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildRangeField('Min'),
            const SizedBox(width: 16),
            _buildRangeField('Max'),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            SizedBox(width: 15),
            Text('0%', style: TextStyle(color: Color(0xFF25AE4B))),
            SizedBox(width: 290),
            Text('50%', style: TextStyle(color: Color(0xFF25AE4B))),
          ],
        ),
        const SizedBox(height: 2),
        RangeSlider(
          values: _discountRange,
          min: 0,
          max: 50,
          divisions:5,
          labels: RangeLabels(
            '${_discountRange.start.toInt()}%',
            '${_discountRange.end.toInt()}%',
          ),
          activeColor: const Color(0xFF25AE4B),
          inactiveColor: const Color(0xFFF5F5F5),
          onChanged: (RangeValues values) {
            setState(() {
              _discountRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRangeField(String label) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEAFBEB), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFF98A0B4), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Color(0xFF98A0B4),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _categories.map((category) {
            final isSelected = _selectedCategories.contains(category);
            return _buildFilterChip(
              category,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category);
                  } else {
                    _selectedCategories.add(category);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            color: Color(0xFF98A0B4),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _locations.map((location) {
            final isSelected = _selectedLocation == location;
            return _buildFilterChip(
              location,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedLocation = isSelected ? null : location;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDishSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dish',
          style: TextStyle(
            color: Color(0xFF98A0B4),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _dishes.map((dish) {
            final isSelected = _selectedDishes.contains(dish);
            return _buildFilterChip(
              dish,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedDishes.remove(dish);
                  } else {
                    _selectedDishes.add(dish);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
      String label, {
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isSelected ? const Color(0xFF25AE4B) : const Color(0xFFF2F4F7),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4B4B4B),
            fontSize: 12,
          ),
        ),
      ),
    );
  }



  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 10000000000);
      _discountRange = const RangeValues(0, 50);
      _selectedCategories.clear();
      _selectedLocation = null;
      _selectedDishes.clear();
    });
  }
}