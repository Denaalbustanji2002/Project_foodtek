import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodtec/view/screens/home_cart/widget/categorise.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/banners.dart';
import '../../../widget/app_bar1.dart';
import '../widget/cart_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double topPadding = 0; // يبدأ بدون إزاحة
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  int selectedCategoryIndex = 0;
  bool isLoading = false;
  List<String> imageUrls = [
    'https://www.google.com/imgres?q=%D8%A7%D9%8A%20%D9%84%D9%8A%D9%86%D9%83%20%D8%B5%D9%88%D8%B1%D9%87%20.png&imgurl=https%3A%2F%2Facademy.hsoub.com%2Fuploads%2Fmonthly_2020_09%2Fthumbnail.thumb.png',
  ];
  int selectedIndex = 0;
  double rating = 3.5;
  String pricefoodItems = "100.0";
  String namefoodItems = "####";
  String descriptionfoodItems = "######################";

  // bool isLoading = true;
  final PageController adController = PageController();
  Section3 section3 = Section3();

  final List<Map<String, String>> categories = [
    {'icon': '🍔', 'name': 'Burgers'},
    {'icon': '🍕', 'name': 'Pizza'},
    {'icon': '🍣', 'name': 'Sushi'},
    {'icon': '🍜', 'name': 'Noodles'},
    {'icon': '🍟', 'name': 'Fries'},
  ];

  @override
  Widget build(BuildContext context) {
    //return  BlocBuilder<OrderCubit, OrderState>(
    // builder: (context, state) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Rated",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      letterSpacing: 0,
                      color: Color(0xFF391713),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 248,
                width: 335,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      // gap بين العناصر
                      child: Stack(
                        children: [
                          // الخلفية مع BoxShadow و BorderRadius
                          Container(
                            width: 155,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 155,
                              height: 209,
                              padding: EdgeInsets.symmetric(
                                vertical: 1,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(10),

                                border: Border.all(
                                  color: Color(0xFFDBF4D1),

                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    initialRating: rating,
                                    // التقييم الافتراضي
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 1,
                                    // عدد النجوم
                                    itemSize: 40,
                                    // حجم النجمة
                                    itemPadding: EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    itemBuilder:
                                        (context, _) => ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            0.5,
                                          ),

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 16.0,
                                                // عرض النجمة
                                                height: 16.0,
                                                // ارتفاع النجمة
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  // اللون داخل النجمة
                                                  size: 16, // حجم النجمة
                                                ),
                                              ),

                                              Text(
                                                rating.toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                    onRatingUpdate: (newRating) {
                                      setState(() {
                                        rating =
                                            newRating; // تحديث التقييم بناءً على التفاعل
                                      });
                                      print("Updated rating: $rating");
                                    },
                                  ),

                                  Container(
                                    width: 131,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/Sent_Message_rafiki 1.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: 2),
                                  // Text Section
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      namefoodItems,
                                      // النص الذي ترغب في عرضه
                                      style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2,
                                        letterSpacing: -3,
                                        color: Color(0xFF391713),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      descriptionfoodItems,
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: .2,
                                        letterSpacing: -3,
                                        color: Color(0xFF3B3B3B),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Container(
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
                                            color: Color(0xFF25AE4B),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),

                                        SizedBox(width: 40),
                                        // لزيادة التباعد
                                        Container(
                                          alignment: Alignment.topCenter,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),

                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.add_circle,
                                              size: 24,
                                              color: Color(0xFF25AE4B),
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      "Recommend",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: .2,
                        letterSpacing: 0,
                        color: Color(0xFF391713),
                      ),
                    ),
                  ),
                  SizedBox(width: 200),
                  Row(
                    children: [
                      Text(
                        "View all",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: 0,
                          color: Color(0xFF25AE4B),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF25AE4B),
                        size: 12, // حجم الأيقونة أصغر
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.only(top: 6, left: 25, right: 16.0),
                child: SizedBox(
                  height: 108,
                  width: 371,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Background image
                            Container(
                              width: 72,
                              height: 108,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/test.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Positioned price text with background
                            Positioned(
                              bottom: 20,
                              right: 2,

                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF25AE4B),
                                  // Background color
                                  borderRadius: BorderRadius.only(
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
                                    color: Colors.white,
                                    height: 11 / 12, // Line height
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
      ),
    );
  }
}
