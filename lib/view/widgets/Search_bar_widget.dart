import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/ordering_screens/filter_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        height: 42,
        width: 370,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Color(0xFFD6D6D6)),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF878787)),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1C1E),
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search menu, restaurant or etc',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF878787),
                    height: 1.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.tune, color: Color(0xFF878787)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
