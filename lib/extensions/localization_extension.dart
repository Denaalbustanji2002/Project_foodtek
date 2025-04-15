import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationHelper on AppLocalizations {
  String getTranslation(String key) {
    switch (key) {
      case 'historyItemChickenBurger':
        return chickenBurger;
      case 'historyItemOnionPizza':
        return onionPizza;
      case 'historyItemSpicyShawarma':
        return spicyShawarma;
      case 'historyItemCheesePasta':
        return cheesePasta;
      case 'historyItemSushiRoll':
        return sushiRoll;
      case 'restaurantBurgerFactory':
        return burgerFactoryLtd;
      case 'restaurantPizzaPalace':
        return pizzaPalace;
      case 'restaurantHotCoolSpot':
        return hotCoolSpot;
      case 'restaurantItaliano':
        return italiano;
      case 'restaurantTokyoSushi':
        return tokyoSushi;
      case 'btnReorder':
        return reorder;
      default:
        return key;
    }
  }
}
