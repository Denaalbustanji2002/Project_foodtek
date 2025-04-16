import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/header_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    _buildSectionTitle(AppLocalizations.of(context)!.filter),
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
        _buildSectionHeading(AppLocalizations.of(context)!.priceRange),
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
                  AppLocalizations.of(context)!.min,
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
                  AppLocalizations.of(context)!.max,
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
                      style:  GoogleFonts.inter(
                        color: Color(0xFF25AE4B),
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
        _buildSectionHeading(AppLocalizations.of(context)!.discount),
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
                  AppLocalizations.of(context)!.min,
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
                  AppLocalizations.of(context)!.max,
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
                    inactiveTrackColor: const Color(
                      0xFF25AE4B,
                    ).withOpacity(0.2),
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
        _buildSectionHeading(AppLocalizations.of(context)!.category),
        Row(
          children: [
            _buildCategoryChip(AppLocalizations.of(context)!.fastFood, 'Fast Food' == _selectedCategory),
            const SizedBox(width: 10),
            _buildCategoryChip(AppLocalizations.of(context)!.seafood, 'Sea Food' == _selectedCategory),
            const SizedBox(width: 10),
            _buildCategoryChip(AppLocalizations.of(context)!.dessert, 'Dessert' == _selectedCategory),
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
            _buildDistanceChip(AppLocalizations.of(context)!.km, '1 KM' == _selectedDistance),
            const SizedBox(width: 10),
            _buildDistanceChip(AppLocalizations.of(context)!.km5, '5 KM' == _selectedDistance),
            const SizedBox(width: 10),
            _buildDistanceChip(AppLocalizations.of(context)!.km10, '10 KM' == _selectedDistance),
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
        _buildSectionHeading(AppLocalizations.of(context)!.dish),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildDishChip(
              AppLocalizations.of(context)!.tunaTartare,
              _selectedDishes.contains(AppLocalizations.of(context)!.tunaTartare),
            ),
            _buildDishChip(
              AppLocalizations.of(context)!.spicyCrabCakes,
              _selectedDishes.contains( AppLocalizations.of(context)!.spicyCrabCakes),
            ),
            _buildDishChip(
              AppLocalizations.of(context)!.seaFoodPaella,
              _selectedDishes.contains(AppLocalizations.of(context)!.seaFoodPaella),
            ),
            _buildDishChip(
              AppLocalizations.of(context)!.clamChowder,
              _selectedDishes.contains(AppLocalizations.of(context)!.clamChowder),
            ),
            _buildDishChip(
              AppLocalizations.of(context)!.misoGlazedCod,
              _selectedDishes.contains(AppLocalizations.of(context)!.misoGlazedCod),
            ),
            _buildDishChip(
              AppLocalizations.of(context)!.lobsterThermidor,
              _selectedDishes.contains(AppLocalizations.of(context)!.lobsterThermidor),
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
}