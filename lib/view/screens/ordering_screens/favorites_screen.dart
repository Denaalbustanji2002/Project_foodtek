import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import '../../../models/favorite_model.dart';
import '../../../theme/app_theme_extensions.dart';
import '../../widgets/Search_bar_widget.dart';
import 'package:foodtek_project/view/widgets/header_widget.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoriteModel> favorites = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favorites = [
      FavoriteModel(
        name: AppLocalizations.of(context)!.pepperoniPizza,
        description: AppLocalizations.of(context)!.pepperoniPizzaDescription,
        price: '29',
        image: 'assets/images/Photo Pizza.png',
        rating: '4.5',
      ),
      FavoriteModel(
        name: AppLocalizations.of(context)!.pizzaCheese,
        description: AppLocalizations.of(context)!.pizzaCheeseDescription,
        price: '23',
        image: 'assets/images/Photo Pizza.png',
        rating: '4.2',
      ),
      FavoriteModel(
        name: AppLocalizations.of(context)!.peppyPaneer,
        description: AppLocalizations.of(context)!.peppyPaneerDescription,
        price: '13',
        image: 'assets/images/Photo Pizza.png',
        rating: '4.0',
      ),
      FavoriteModel(
        name: AppLocalizations.of(context)!.mexicanGreenWave,
        description: AppLocalizations.of(context)!.mexicanGreenWaveDescription,
        price: '23',
        image: 'assets/images/Photo Pizza.png',
        rating: '4.1',
      ),
    ];
    setState(() {});
  }

  void removeFavorite(int index) {
    setState(() {
      favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarColor,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 20,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: HeaderWidget(),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBarWidget(),
            SizedBox(height: responsiveHeight(context, 16)),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                AppLocalizations.of(context)!.favorites,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: theme.titleColor,
                  height: 1.0,
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  favorites.isEmpty
                      ? _buildEmptyFavorites(local)
                      : _buildFavoritesList(local),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites(AppLocalizations local) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 70, color: theme.disabledColor),
          const SizedBox(height: 16),
          Text(
            local.noFavoritesYet,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: theme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            local.noFavoritesYet,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: theme.hintTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(AppLocalizations local) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 0.7,
        ),
        itemCount: favorites.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildFavoriteItem(favorites[index], index, local);
        },
      ),
    );
  }

  Widget _buildFavoriteItem(
    FavoriteModel item,
    int index,
    AppLocalizations local,
  ) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: responsiveWidth(context, 174),
              height: responsiveHeight(context, 200),
              margin: EdgeInsets.only(top: 44.5),
              decoration: BoxDecoration(
                color: theme.containerColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: theme.mildGreenColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveHeight(context, 14),
                            height: 15 / 14,
                            letterSpacing: 0.0,
                            color: theme.titleColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: responsiveHeight(context, 8)),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w300,
                            fontSize: responsiveHeight(context, 10),
                            height: 12 / 10,
                            color: theme.secondaryTextColor,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: responsiveHeight(context, 12)),
                        Text(
                          '\$${item.price}',
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w600,
                            fontSize: responsiveHeight(context, 14),
                            height: 15 / 14,
                            color: theme.titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 30)),
                ],
              ),
            ),
            Positioned(
              bottom: responsiveHeight(context, -10.5),
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: responsiveWidth(context, 95),
                  height: responsiveHeight(context, 27),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: theme.buttonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.orderNow,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveHeight(context, 10),
                        height: 15 / 10,
                        letterSpacing: 0.0,
                        color: theme.buttonTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: responsiveHeight(context, 30),
              right: responsiveWidth(context, -5),
              child: GestureDetector(
                onTap: () {
                  showNotificationDialog(
                    context,
                    AppLocalizations.of(
                      context,
                    )!.areYouSureYouWantToRemoveFromFavorites,
                    onConfirm: () {
                      removeFavorite(index);
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.mildGreenColor,
                    border: Border.all(color: theme.mildGreenColor, width: 2),
                  ),
                  width: responsiveWidth(context, 35),
                  height: responsiveHeight(context, 35),
                  child: Icon(
                    Icons.favorite,
                    size: responsiveHeight(context, 13),
                    color: theme.spicyRedColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: responsiveWidth(context, 89),
                  height: responsiveHeight(context, 89),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.disabledColor,
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.fill,
                      width: responsiveWidth(context, 74),
                      height: responsiveHeight(context, 74),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showNotificationDialog(
    BuildContext context,
    String message, {
    required VoidCallback onConfirm,
  }) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 343,
            height: 154,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.containerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    height: 1.4,
                    letterSpacing: -0.01,
                    color: theme.secondaryTextColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shadowColor: theme.shadowColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 1,
                              color: theme.borderColor!,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 24,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.4,
                            letterSpacing: -0.01,
                            color: theme.buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
