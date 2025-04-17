import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubits/navigation_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../theme/app_theme_extensions.dart';
import 'app_tab.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        height: 42,
        width: 370,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: theme.containerColor,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: theme.borderColor),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: theme.iconColor),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: theme.textFieldTextColor,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.searchHint,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.hintTextColor,
                    height: 1.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.tune, color: theme.iconColor),
              onPressed: () {
                context.read<NavigationCubit>().changeTab(AppTab.track);
                Navigator.pushNamed(
                  context,
                  '/filterScreen',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
