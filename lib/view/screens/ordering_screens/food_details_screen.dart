import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodtek_project/view/screens/location_screen/delivery_tracking_screen.dart';
import '../../../cubits/cart_cubit.dart';
import '../../../models/cart_model.dart';
import '../profile_screens/profile_screen.dart';
import 'cart_history_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/header_widget.dart';
import '../../../helper/responsive.dart';

class RectSliderThumbShape extends SliderComponentShape {
  final double thumbWidth;
  final double thumbHeight;

  RectSliderThumbShape({this.thumbWidth = 12.0, this.thumbHeight = 20.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.red
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(4)),
      paint,
    );
  }
}

class FoodDetailScreen extends StatefulWidget {
  final String name;
  final String description;
  final String rating;
  final String price;
  final String imagePath;

  const FoodDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 3;
  double _spicyValue = 0.3;
  int currentIndex = 2;

  void onItemTapped(int index) {
    Widget? nextScreen;

    switch (index) {
      case 0:
        nextScreen = HomeScreen();
        break;
      case 1:
        nextScreen = FavoritesScreen();
        break;
      case 3:
        nextScreen = DeliveryTrackingScreen();
        break;
      case 4:
        nextScreen = ProfileScreen();
        break;
    }

    if (nextScreen != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen!),
      );
      setState(() {
        currentIndex = index;
      });
    }
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
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: HeaderWidget(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SearchBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFoodImage(),
                    SizedBox(height: responsiveHeight(context, 24)),
                    buildFoodName(),
                    SizedBox(height: responsiveHeight(context, 8)),
                    buildRatingRow(),
                    SizedBox(height: responsiveHeight(context, 10)),
                    buildPriceRow(),
                    SizedBox(height: responsiveHeight(context, 16)),
                    buildDescription(),
                    SizedBox(height: responsiveHeight(context, 24)),
                    buildSpicyAndQuantityRow(),
                    SizedBox(height: responsiveHeight(context, 24)),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        width: 330,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF25AE4B),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF85DE9E),
                              offset: Offset.zero,
                              blurRadius: 0,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: const Color(0x7A253EA7),
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                              spreadRadius: 0,
                            ),
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF25AE4B),
                              Color(0xFF25AE4B),
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            final item = CartModel(
                              title: widget.name,
                              price: double.tryParse(widget.price) ?? 0.0,
                              count: _quantity,
                              imagePath: widget.imagePath,
                            );

                            context.read<CartCubit>().addToCart(item);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.title} has been added to the cart')),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => CartHistoryScreen()),
                            );
                          },

                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:  Text(
                            'Add To Cart',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: responsiveHeight(context, 14),
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              letterSpacing: -0.14,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ),
                      ),
                    )],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFoodImage() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: 370,
          height: 203,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/food_details_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          right: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFoodName() {
    return Text(
      widget.name,
      style: GoogleFonts.inter(
        fontSize: responsiveHeight(context, 20),
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1B1B1B),
      ),
    );
  }

  Widget buildRatingRow() {
    return Row(
      children: [
        ...List.generate(
          4,
              (_) => const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
        ),
        const Icon(Icons.star_half, color: Color(0xFFFFC107), size: 18),
        SizedBox(width: responsiveWidth(context, 6)),
        Text(
          widget.rating,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 12),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF868889),
          ),
        ),
      ],
    );
  }

  Widget buildPriceRow() {
    return Row(
      children: [
        Text(
          "\$${widget.price}",
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 20),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF009944),
          ),
        ),
        SizedBox(width: responsiveWidth(context, 8)),
        Text(
          "\$9.5",
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 16),
            decoration: TextDecoration.lineThrough,
            color: const Color(0xFF838383),
          ),
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Text(
      widget.description,
      style: GoogleFonts.inter(
        color: const Color(0xFF838383),
        fontSize: responsiveHeight(context, 12),
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget buildSpicyAndQuantityRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 169,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spicy',
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF838383),
                ),
              ),
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xFFEF2A39),
                      inactiveTrackColor: const Color(0xFFF3F4F6),
                      thumbColor: const Color(0xFFEF2A39),
                      trackHeight: 3,
                      thumbShape: RectSliderThumbShape(
                        thumbWidth: 10,
                        thumbHeight: 14,
                      ),
                    ),
                    child: Slider(
                      value: _spicyValue,
                      onChanged: (value) {
                        setState(() => _spicyValue = value);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mild',
                        style: GoogleFonts.poppins(
                          fontSize: responsiveHeight(context, 12),
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1CC019),
                          height: 1.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                      Text(
                        'Hot',
                        style: GoogleFonts.poppins(
                          fontSize: responsiveHeight(context, 12),
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFEF2A39),
                          height: 1.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(context, 12),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF838383),
                height: 1.0,
                letterSpacing: 0.0,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildIconButton(
                  icon: Icons.remove,
                  iconColor: const Color(0xFF25AE4B),
                  backgroundColor: const Color(0xFFF2F2F2),
                  size: 26,
                  onTap: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                Container(
                  width: responsiveWidth(context, 42),
                  alignment: Alignment.center,
                  child: Text(
                    '$_quantity',
                    style: GoogleFonts.poppins(
                      fontSize: responsiveHeight(context, 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF181818),
                    ),
                  ),
                ),
                _buildIconButton(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  backgroundColor: const Color(0xFF25AE4B),
                  size: 26,
                  onTap: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
    required double size,
  }) {
    return Container(
      width: responsiveWidth(context, size),
      height: responsiveHeight(context, size),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: iconColor,
          size: responsiveHeight(context, size * 0.7),
        ),
      ),
    );
  }
}