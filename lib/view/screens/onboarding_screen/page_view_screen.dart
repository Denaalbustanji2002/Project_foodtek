import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/onboarding_screen/turn_on_your_location.dart';
import 'package:foodtec/view/screens/onboarding_screen/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../helper/responsive.dart';
import 'choose_your_food_screen.dart';
import 'get_delivery_screen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => setState(() => currentPage = index),
              children: [
                WelcomeScreen(pageController: pageController),
                GetDeliveryScreen(pageController: pageController),
                ChooseYourFoodScreen(pageController: pageController),
                //TurnOnYourLocation(),
              ],
            ),
          ),
          _buildBottomControls(context),
        ],
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(context, 24),
        vertical: responsiveHeight(context, 55),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSkipButton(),
          _buildPageIndicator(),
          _buildForwardButton(),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed:
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TurnOnYourLocation()),
          ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(context, 16),
          vertical: responsiveHeight(context, 12),
        ),
      ),
      child: Text(
        "Skip",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF455A64),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3, // Fixed count to match 4 pages
      effect: const SlideEffect(
        spacing: 8.0,
        radius: 12.0,
        dotWidth: 10.0,
        dotHeight: 10.0,
        dotColor: Colors.grey,
        activeDotColor: Color(0XFF25AE4B),
      ),
    );
  }

  Widget _buildForwardButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_forward, color: Color(0XFF25AE4B)),
      iconSize: 24,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      splashRadius: 20,
      onPressed:
          () =>
              currentPage == 3
                  ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TurnOnYourLocation(),
                    ),
                  )
                  : pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
    );
  }
}
