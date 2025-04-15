import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  List<Map<String, dynamic>> allHistoryItems = [
    {
      'title': 'historyItemChickenBurger',
      'restaurant': 'restaurantBurgerFactory',
      'price': '\$20',
      'date': '25.3.2024',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'btnReorder',
    },
    {
      'title': 'historyItemOnionPizza',
      'restaurant': 'restaurantPizzaPalace',
      'price': '\$15',
      'date': '25.3.2024',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'btnReorder',
    },
    {
      'title': 'historyItemSpicyShawarma',
      'restaurant': 'restaurantHotCoolSpot',
      'price': '\$15',
      'date': '25.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'btnReorder',
    },
    {
      'title': 'historyItemCheesePasta',
      'restaurant': 'restaurantItaliano',
      'price': '\$18',
      'date': '24.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'btnReorder',
    },
    {
      'title': 'historyItemSushiRoll',
      'restaurant': 'restaurantTokyoSushi',
      'price': '\$22',
      'date': '24.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'btnReorder',
    },
  ];

  List<Map<String, dynamic>> visibleHistoryItems = [];

  void loadHistory() {
    visibleHistoryItems = allHistoryItems.take(3).toList();
    emit(
      HistoryLoaded(
        allHistoryItems: allHistoryItems,
        visibleHistoryItems: visibleHistoryItems,
      ),
    );
  }

  void loadMoreHistory() {
    final nextItems = allHistoryItems.skip(visibleHistoryItems.length).take(3);
    visibleHistoryItems.addAll(nextItems);
    emit(
      HistoryLoaded(
        allHistoryItems: allHistoryItems,
        visibleHistoryItems: visibleHistoryItems,
      ),
    );
  }

  void deleteHistoryItem(Map<String, dynamic> item) {
    allHistoryItems.remove(item);
    visibleHistoryItems.remove(item);
    emit(
      HistoryLoaded(
        allHistoryItems: allHistoryItems,
        visibleHistoryItems: visibleHistoryItems,
      ),
    );
  }
}
