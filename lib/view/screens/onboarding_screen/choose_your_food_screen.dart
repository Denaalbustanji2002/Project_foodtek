import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/onboarding_screen/turn_on_your_location.dart';

import '../../../helper/responsive.dart';

import '../../widget/section1.dart';

class ChooseYourFoodScreen extends StatefulWidget {
  final PageController pageController;

  const ChooseYourFoodScreen({super.key, required this.pageController});

  @override
  State<ChooseYourFoodScreen> createState() => _ChooseYourFoodScreen();
}

class _ChooseYourFoodScreen extends State<ChooseYourFoodScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    section1 section = section1();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          section.buildTopImage(context, "assets/images/splash_screen.png"),
          section.buildCenterImage(context, "assets/images/TakeAway.png"),
          section.buildWelcomeText(
            context,
            "assets/images/choose_your_food.png",
          ),
          section.buildContinueButton(
            context,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TurnOnYourLocation()),
              );
            },
            'continue',
            responsiveHeight(context, 712),
          ),
        ],
      ),
    );
  }
}
