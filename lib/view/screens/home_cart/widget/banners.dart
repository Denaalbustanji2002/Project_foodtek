import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/ThemeCubit.dart';
import '../../../../states/ThemeState.dart';


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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {

        Color backgroundColor = state.themeMode == ThemeMode.dark
            ? Colors.grey[850]!
            : Colors.grey[200]!;
        Color activeDotColor = state.themeMode == ThemeMode.dark
            ? const Color(0xFF25AE4B)
            : const Color(0xFF1E7B31);

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
                      color: backgroundColor, // تغيير اللون الخلفي بناءً على الثيم
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
              effect: WormEffect(
                dotHeight: 3,
                dotWidth: 18,
                dotColor: const Color(0XFFDBF4D1),
                activeDotColor: activeDotColor, // تغيير لون الدوائر بناءً على الثيم
                spacing: 4,
              ),
            ),
          ],
        );
      },
    );
  }
}
