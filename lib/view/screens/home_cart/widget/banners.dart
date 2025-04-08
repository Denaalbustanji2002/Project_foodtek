import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Banners extends StatelessWidget {
  final bool isLoading;
  final List<String> imageUrls;
  final PageController adController;

  const Banners({
    super.key,
    required this.isLoading,
    required this.imageUrls,
    required this.adController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: adController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(imageUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: adController,
          count: imageUrls.length,
          effect: const WormEffect(
            dotHeight: 3,
            dotWidth: 18,
            dotColor: Color(0XFFDBF4D1),
            activeDotColor: Color(0xFF25AE4B),
            spacing: 4,
          ),
        ),
      ],
    );
  }
}