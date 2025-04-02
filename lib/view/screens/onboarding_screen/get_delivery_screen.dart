import 'package:flutter/material.dart';
import '../../../helper/responsive.dart';
import '../../widget/section1.dart';

class GetDeliveryScreen extends StatefulWidget {
  final PageController pageController;

  const GetDeliveryScreen({super.key, required this.pageController});

  @override
  State<GetDeliveryScreen> createState() => _GetDeliveryScreenState();
}

class _GetDeliveryScreenState extends State<GetDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    section1 section = section1();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          section.buildTopImage(context, "assets/images/splash_screen.png"),
          section.buildCenterImage(context, "assets/images/TakeAway.png"),
          section.buildWelcomeText(
            context,
            "assets/images/get_delivery_on_time.png",
          ),
          section.buildContinueButton(
            context,
            () {
              widget.pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
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
