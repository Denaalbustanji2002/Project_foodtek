abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Map<String, dynamic>> allHistoryItems;
  final List<Map<String, dynamic>> visibleHistoryItems;

  HistoryLoaded({
    required this.allHistoryItems,
    required this.visibleHistoryItems,
  });
}
