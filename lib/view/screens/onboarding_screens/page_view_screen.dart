import 'package:flutter/material.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/turn_on_your_location.dart';
import 'package:foodtek_project/view/screens/onboarding_screens/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../helper/responsive.dart';
import '../authentication_screens/login_screen.dart';
import 'choose_your_food_screen.dart';
import 'get_delivery_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController pageController = PageController();
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
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                WelcomeScreen(pageController: pageController),
                GetDeliveryScreen(pageController: pageController),
                ChooseYourFoodScreen( pageController: pageController),
              ],
            ),
          ),
          buildBottomControls(context, pageController),
        ],
      ),
    );
  }

  Widget buildBottomControls(BuildContext context,
      PageController pageController) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: responsiveHeight(context, 60)),
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSkipButton(context),
              SizedBox(width: 70),
              buildPageIndicator(context, pageController),
              SizedBox(width: 50),
              buildForwardButton(context, pageController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkipButton(BuildContext context) {
    return SizedBox(
      width: 107,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: SizedBox(
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFF455A64),
              height: 1.00,
              letterSpacing: 0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildPageIndicator(BuildContext context,
      PageController pageController) {
    return SizedBox(
      width: responsiveWidth(context, 46),
      height: responsiveHeight(context, 10),
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        axisDirection: Axis.horizontal,
        effect: SlideEffect(
          spacing: 5.5,
          radius: 4.0,
          dotWidth: 10.0,
          dotHeight: 10.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: Colors.grey,
          activeDotColor: Color(0XFF25AE4B),
        ),
      ),
    );
  }

  Widget buildForwardButton(BuildContext context,
      PageController pageController) {
    return SizedBox(
      width: responsiveWidth(context, 107),
      child: IconButton(
        icon: Icon(Icons.arrow_forward),
        onPressed: () {
          if (pageController.page == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TurnOnYourLocation()),
            );
          } else {
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}