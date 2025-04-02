import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Banners extends StatelessWidget {
  final bool isLoading;
  final List<String> imageUrls;
  final PageController adController;

  const Banners({
    Key? key,
    required this.isLoading,
    required this.imageUrls,
    required this.adController,
  }) : super(key: key);

  // دالة لبناء كل Slide مع تطبيق التصميم المطلوب
  Widget buildSlide(String url) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:10, vertical: 2),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imageUrls.isEmpty
          ? const Center(child: Text("No images available"))
          : Column(
        children: [
          SizedBox(
            height: 137,
            child: PageView(
              controller: adController,
              physics: const BouncingScrollPhysics(),
              children: imageUrls.map((url) => buildSlide(url)).toList(),
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: adController,
            count: imageUrls.length,
            effect: const WormEffect(
              dotWidth: 20.0,
              dotHeight: 4.0,
              activeDotColor: Color(0xFF25AE4B),
              dotColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
