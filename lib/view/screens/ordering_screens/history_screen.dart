import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodtek_project/extensions/localization_extension.dart';
import 'package:foodtek_project/view/widgets/spin_kit_hour_glass_widget.dart';
import '../../../cubits/history_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/history_state.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/header_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 30,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: const HeaderWidget(),
        ),
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return _buildHistoryContent(state);
          }
          return const Center(child: SpinKitHourGlassWidget());
        },
      ),
    );
  }

  Widget _buildHistoryContent(HistoryLoaded state) {
    if (state.visibleHistoryItems.isEmpty) {
      return EmptyWidget(
        imagePath: "assets/images/empty.png",
        title: AppLocalizations.of(context)!.historyEmpty,
        description:
            AppLocalizations.of(context)!.youDontHaveAddAnyHistoryAtThisTime,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...state.visibleHistoryItems
              .map((item) => _buildHistoryItem(item))
              .toList(),
          _buildLoadMoreButton(state),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    String tr(String key) => AppLocalizations.of(context)!.getTranslation(key);

    return Slidable(
      closeOnScroll: true,
      key: ValueKey(item['title']),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) => showDeleteConfirmationDialog(context, item),
            backgroundColor: const Color(0xFFFDAC1D),
            child: Icon(
              Icons.delete_outline,
              size: responsiveHeight(context, 25),
              color: Colors.white,
            ),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: const BorderSide(color: Color(0xFFDBF4D1), width: 1),
        ),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              _buildHistoryItemImage(item),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr(item['title']),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tr(item['restaurant']),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['price'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF25AE4B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: responsiveHeight(context, 16)),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['date'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.replay,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  tr(item['reorder'] ?? 'btn_reorder'),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItemImage(Map<String, dynamic> item) {
    final imagePath = item['image'] ?? '';

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imagePath,
        width: 65,
        height: 65,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
      ),
    );
  }

  Widget _buildLoadMoreButton(HistoryLoaded state) {
    final isAllLoaded =
        state.visibleHistoryItems.length >= state.allHistoryItems.length;

    if (isAllLoaded) return const SizedBox();

    return TextButton(
      onPressed: () {
        context.read<HistoryCubit>().loadMoreHistory();
      },
      child: Text(
        AppLocalizations.of(context)!.loadMore,
        style: TextStyle(
          color: Color(0xFF25AE4B),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmDeleteHistoryTitle),
          content: Text(
              "${AppLocalizations.of(context)!.confirmDeleteHistoryContent1} ${AppLocalizations.of(context)!.getTranslation(item['title'])}${AppLocalizations.of(context)!.confirmDeleteHistoryContent2}",
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.delete),
              onPressed: () {
                context.read<HistoryCubit>().deleteHistoryItem(item);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
