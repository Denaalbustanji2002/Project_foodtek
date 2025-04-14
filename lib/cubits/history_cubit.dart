import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  List<Map<String, dynamic>> allHistoryItems = [
    {
      'title': 'Chicken Burger',
      'restaurant': 'Burger Factory LTD',
      'price': '\$20',
      'date': '25.3.2024',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'Reorder',
    },
    {
      'title': 'Onion Pizza',
      'restaurant': 'Pizza Palace',
      'price': '\$15',
      'date': '25.3.2024',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'Reorder',
    },
    {
      'title': 'Spicy Shawarma',
      'restaurant': 'Hot Cool Spot',
      'price': '\$15',
      'date': '25.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'Reorder',
    },
    {
      'title': 'Cheese Pasta',
      'restaurant': 'Italiano',
      'price': '\$18',
      'date': '24.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'Reorder',
    },
    {
      'title': 'Sushi Roll',
      'restaurant': 'Tokyo Sushi',
      'price': '\$22',
      'date': '24.3.2024',
      'count': '0',
      'image': 'assets/images/history_menu_food.png',
      'reorder': 'Reorder',
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
