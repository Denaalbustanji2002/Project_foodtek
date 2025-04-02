import 'package:flutter/material.dart';
import '../../../helper/responsive.dart';
import '../../widget/section1.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController pageController;

  const WelcomeScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    section1 section = section1();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          section.buildTopImage(context, "assets/images/splash_screen.png"),
          section.buildCenterImage(
            context,
            "assets/images/Order food-pana.png",
          ),
          section.buildWelcomeText(
            context,
            "assets/images/welcome_to_sahlah.png",
          ),
          section.buildContinueButton(
            context,
            () {
              if (pageController.hasClients) {
                pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                debugPrint("Error: pageController is not connected to a page.");
              }
            },
            'continue',
            responsiveHeight(context, 712),
          ),
        ],
      ),
    );
  }
}
