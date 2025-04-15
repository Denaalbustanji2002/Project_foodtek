import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodtek_project/extensions/localization_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/history_cubit.dart';
import '../../../helper/responsive.dart';
import '../../../states/history_state.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/header_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartHistoryScreen extends StatefulWidget {
  const CartHistoryScreen({super.key});

  @override
  State<CartHistoryScreen> createState() => _CartHistoryScreenState();
}

class _CartHistoryScreenState extends State<CartHistoryScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> cartItems = [];
  String kCartType = 'cart';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (context.read<HistoryCubit>().state is HistoryInitial) {
      context.read<HistoryCubit>().loadHistory();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartItems = [
      {
        'title': AppLocalizations.of(context)!.chickenBurger,
        'restaurant': AppLocalizations.of(context)!.burgerFactoryLtd,
        'price': '\$20',
        'count': 0,
      },
      {
        'title': AppLocalizations.of(context)!.onionPizza,
        'restaurant': AppLocalizations.of(context)!.pizzaPalace,
        'price': '\$15',
        'count': 0,
      },
      {
        'title': AppLocalizations.of(context)!.spicyShawarma,
        'restaurant': AppLocalizations.of(context)!.hotCoolSpot,
        'price': '\$15',
        'count': 0,
      },
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: kToolbarHeight + 30,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: const HeaderWidget(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF25AE4B),
          unselectedLabelColor: const Color(0xFF98A0B4),
          indicatorColor: const Color(0xFF25AE4B),
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Text(
                AppLocalizations.of(context)!.cart,
                style: _tabTextStyle(),
              ),
            ),
            Tab(
              child: Text(
                AppLocalizations.of(context)!.history,
                style: _tabTextStyle(),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCartContent(), _buildHistoryContent()],
      ),
    );
  }

  TextStyle _tabTextStyle() {
    return GoogleFonts.inter(
      fontSize: responsiveHeight(context, 16),
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildCartContent() {
    if (cartItems.isEmpty) {
      return EmptyWidget(
        imagePath: "assets/images/empty.png",
        title: AppLocalizations.of(context)!.cartEmpty,
        description:
            AppLocalizations.of(
              context,
            )!.youDontHaveAddAnyFoodsInCartAtThisTime,
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: responsiveHeight(context, 16)),
            ...cartItems.map(
              (item) => KeyedSubtree(
                key: ValueKey(item['title']),
                child: _buildCartItem(item, () {
                  setState(() {
                    cartItems.remove(item);
                  });
                }),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 50)),
            _buildOrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryContent() {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
          if (state.visibleHistoryItems.isEmpty) {
            return EmptyWidget(
              imagePath: "assets/images/empty.png",
              title: AppLocalizations.of(context)!.historyEmpty,
              description:
                  AppLocalizations.of(
                    context,
                  )!.youDontHaveAddAnyHistoryAtThisTime,
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ...state.visibleHistoryItems.map(
                    (item) => _buildHistoryItem(item),
                  ),
                  _buildLoadMoreButton(state),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, Function onDelete) {
    return Slidable(
      closeOnScroll: true,
      key: ValueKey(item['title']),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed:
                (context) =>
                    showDeleteConfirmationDialog(context, item, "cart"),
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
              _buildItemImage(),
              SizedBox(width: 12),
              _buildItemDetails(item),
              _buildCounter(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemImage() {
    return Container(
      width: responsiveWidth(context, 62.18),
      height: responsiveHeight(context, 62),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9012),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Image.asset(
        "assets/images/cart_menu_food.png",
        height: responsiveHeight(context, 62),
        width: responsiveWidth(context, 62.18),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildItemDetails(Map<String, dynamic> item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['title'],
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: responsiveHeight(context, 15),
              color: Colors.black,
            ),
          ),
          SizedBox(height: responsiveHeight(context, 4)),
          Text(
            item['restaurant'],
            style: GoogleFonts.inter(
              color: const Color(0xFF3B3B3B),
              fontWeight: FontWeight.w400,
              fontSize: responsiveHeight(context, 12),
            ),
          ),
          SizedBox(height: responsiveHeight(context, 4)),
          Text(
            item['price'],
            style: GoogleFonts.inter(
              color: const Color(0xFF25AE4B),
              fontWeight: FontWeight.w700,
              fontSize: responsiveHeight(context, 19),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(Map<String, dynamic> item) {
    return Row(
      children: [
        _buildDecreaseButton(item),
        _buildCountDisplay(item),
        _buildIncreaseButton(item),
      ],
    );
  }

  Widget _buildDecreaseButton(Map<String, dynamic> item) {
    return Container(
      width: responsiveWidth(context, 26),
      height: responsiveHeight(context, 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (item['count'] > 0) item['count']--;
          });
        },
        child: Icon(
          Icons.remove,
          color: const Color(0xFF25AE4B),
          size: responsiveHeight(context, 18),
        ),
      ),
    );
  }

  Widget _buildCountDisplay(Map<String, dynamic> item) {
    return Container(
      width: responsiveWidth(context, 42),
      alignment: Alignment.center,
      child: Text(
        item['count'].toString(),
        style: GoogleFonts.poppins(
          fontSize: responsiveHeight(context, 16),
          fontWeight: FontWeight.w500,
          color: const Color(0xFF181818),
        ),
      ),
    );
  }

  Widget _buildIncreaseButton(Map<String, dynamic> item) {
    return Container(
      width: responsiveWidth(context, 26),
      height: responsiveHeight(context, 26),
      decoration: BoxDecoration(
        color: const Color(0xFF25AE4B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            item['count']++;
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: responsiveHeight(context, 18),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      height: responsiveHeight(context, 206),
      width: responsiveWidth(context, 378),
      decoration: BoxDecoration(
        color: const Color(0xFF25AE4B),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.subTotal,
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
                Text(
                  '100 \$',
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(context, 6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.deliveryCharge,
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
                Text(
                  '10 \$',
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(context, 6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.discount,
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
                Text(
                  '10 \$',
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(context, 6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.total,
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontSize: responsiveHeight(context, 18),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '110\$',
                  style: GoogleFonts.inter(
                    color: const Color(0XFFFEFEFF),
                    fontSize: responsiveHeight(context, 18),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: responsiveHeight(context, 16)),
            Container(
              width: responsiveWidth(context, 366.02),
              height: responsiveHeight(context, 50),
              decoration: BoxDecoration(
                color: const Color(0XFFFEFEFF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.placeMyOrder,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF34B56F),
                    fontSize: responsiveHeight(context, 14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
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
            onPressed:
                (context) =>
                    showDeleteConfirmationDialog(context, item, "history"),
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
                                TextButton(
                                  onPressed: () {
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    tr(item['reorder'] ?? 'btnReorder'),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                    ),
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
                color:
                    item['title'] == AppLocalizations.of(context)!.chickenBurger
                        ? Colors.amber
                        : item['title'] ==
                            AppLocalizations.of(context)!.onionPizza
                        ? Colors.red.shade300
                        : Colors.orange,
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
    String tab,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmDeleteHistoryTitle),
          content: Text(
            tab == kCartType
                ? "${AppLocalizations.of(context)!.confirmDeleteHistoryContent1} ${AppLocalizations.of(context)!.getTranslation(item['title'])}${AppLocalizations.of(context)!.confirmDeleteCartContent1}"
                : "${AppLocalizations.of(context)!.confirmDeleteHistoryContent1} ${AppLocalizations.of(context)!.getTranslation(item['title'])}${AppLocalizations.of(context)!.confirmDeleteHistoryContent2}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                if (tab == kCartType) {
                  setState(() {
                    cartItems.remove(item);
                  });
                } else {
                  context.read<HistoryCubit>().deleteHistoryItem(item);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
