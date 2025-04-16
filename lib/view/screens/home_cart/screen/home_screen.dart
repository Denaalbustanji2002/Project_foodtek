import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/screen_index.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../widget/custom_app_bar.dart';
import '../widget/banners.dart';
import '../widget/categorise.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  bool isLoading = false;
  List<String> imageUrls = [
    'https://via.placeholder.com/350x150?text=Banner+1',
    'https://via.placeholder.com/350x150?text=Banner+2',
    'https://via.placeholder.com/350x150?text=Banner+3',
    'https://via.placeholder.com/350x150?text=Banner+3',
    'https://via.placeholder.com/350x150?text=Banner+3',
  ];
  int selectedIndex = 0;
  double rating = 3.5;
  String pricefoodItems = "100.0";
  String namefoodItems = "Burger Special";
  String descriptionfoodItems = "Delicious beef burger";

  final PageController adController = PageController();

  final List<Map<String, String>> categories = [
    {'icon': '', 'name': 'All'},
    {'icon': '🍔', 'name': 'Burgers'},
    {'icon': '🍕', 'name': 'Pizza'},
    {'icon': '🍣', 'name': 'Sushi'},
    {'icon': '🍜', 'name': 'Noodles'},
    {'icon': '🍟', 'name': 'Fries'},
  ];

  @override
  void dispose() {
    adController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(child: CategoriesWidget(categories: categories)),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 19,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Banners(
                    isLoading: isLoading,
                    imageUrls: imageUrls,
                    adController: adController,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
              width: 335,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  "Top Rated",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    letterSpacing: 0,
                    color: colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 235,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Stack(
                      children: [
                        Container(
                          width: 155,
                          height: 212,
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 155,
                            height: 230,
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: colorScheme.primary.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 1,
                                  itemSize: 40,
                                  itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 2.0,
                                  ),
                                  itemBuilder: (context, _) => ClipRRect(
                                    borderRadius: BorderRadius.circular(0.5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 16.0,
                                          height: 16.0,
                                          child: const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          rating.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onRatingUpdate: (newRating) {
                                    setState(() {
                                      rating = newRating;
                                    });
                                  },
                                ),
                                Container(
                                  width: 131,
                                  height: 74,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Sent_Message_rafiki 1.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    namefoodItems,
                                    style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                      letterSpacing: -0.5,
                                      color: colorScheme.onSurface,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    descriptionfoodItems,
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                      letterSpacing: -0.5,
                                      color: colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  height: 24,
                                  width: 138,
                                  child: Row(
                                    children: [
                                      Text(
                                        "\$$pricefoodItems",
                                        style: GoogleFonts.dmSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                          letterSpacing: 0.5,
                                          color: Colors.green,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 42),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          color: colorScheme.surface,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            //context.read<NavigationCubit>().goTo(ScreenIndex.CartScreen);
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            size: 24,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 32, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommend",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      letterSpacing: 0,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "View all",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: 0,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: colorScheme.primary,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, left: 32, right: 16.0),
              child: SizedBox(
                height: 108,
                width: 371,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 72,
                            height: 108,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/test.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                "\$$pricefoodItems",
                                style: TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: colorScheme.onPrimary,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}