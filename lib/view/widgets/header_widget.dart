import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/location_screen/location_screen.dart';
import 'notifications_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(
            Icons.pin_drop_outlined,
            color: Color(0xFF4FAF5A),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationScreen()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.currentLocation,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF606060),
                    ),
                  ),
                  Text(
                   AppLocalizations.of(context)!.locationHeader,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF101010),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => NotificationsBottomSheet(
                        scrollController: ScrollController(),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
