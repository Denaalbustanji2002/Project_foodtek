import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:foodtek_project/view/widgets/empty_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/header_widget.dart';
import '../profile_screens/profile_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

class CartHistoryScreen extends StatefulWidget {
  const CartHistoryScreen({super.key});

  @override
  State<CartHistoryScreen> createState() => _CartHistoryScreenState();
}

class _CartHistoryScreenState extends State<CartHistoryScreen>
    with SingleTickerProviderStateMixin {

  List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Chicken Burger',
      'restaurant': 'Burger Factory LTD',
      'price': '\$20',
      'count': 0,
    },
    {
      'title': 'Onion Pizza',
      'restaurant': 'Pizza Palace',
      'price': '\$15',
      'count': 0,
    },
    {
      'title': 'Spicy Shawarma',
      'restaurant': 'Hot Cool Spot',
      'price': '\$15',
      'count': 0,
    },
  ];

  List<Map<String, dynamic>> historyItems = [
    {
      'title': 'Chicken Burger',
      'restaurant': 'Burger Factory LTD',
      'price': '\$20',
      'date': '25.3.2024',
    },
    {
      'title': 'Onion Pizza',
      'restaurant': 'Pizza Palace',
      'price': '\$15',
      'date': '25.3.2024',
    },
    {
      'title': 'Spicy Shawarma',
      'restaurant': 'Hot Cool Spot',
      'price': '\$15',
      'date': '25.3.2024',
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              Tab(child: Text('Cart', style: _tabTextStyle())),
              Tab(child: Text('History', style: _tabTextStyle())),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_buildCartContent(), _buildHistoryContent()],
        ),
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
        title: "Cart Empty",
        description: "You don't have add any foods in cart at this time",
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
    if (historyItems.isEmpty) {
      return EmptyWidget(
          imagePath: "assets/images/empty.png",
          title: "History Empty",
          description: "You don't have any history at this time");
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...historyItems.map((item) => _buildHistoryItem(item)),
            _buildLoadMoreButton(),
          ],
        ),
      ),
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
            onPressed: (context) => showDeleteConfirmationDialog(context, item, "Cart"),
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
      child: Image.asset(""),
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
                  'Sub-Total',
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
                  'Delivery Charge',
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
                  'Discount',
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
                  'Total:',
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
              height: responsiveHeight(context, 57),
              decoration: BoxDecoration(
                color: const Color(0XFFFEFEFF),
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Place My Order',
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
    return Slidable(
      closeOnScroll: true,
      key: ValueKey(item['title']),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) => showDeleteConfirmationDialog(context, item, "history"),
            backgroundColor: const Color(0xFFFDAC1D),
            child: Icon(
              Icons.delete_outline,
              size: responsiveHeight(context, 25),
              color: Colors.white,
            ),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHistoryItemImage(item),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
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
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['restaurant'],
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHistoryItemImage(Map<String, dynamic> item) {
    String imagePath = "";
    if (item['title'] == 'Chicken Burger') {
      imagePath = "assets/burger.jpg";
    } else if (item['title'] == 'Onion Pizza') {
      imagePath = "assets/pizza.jpg";
    } else if (item['title'] == 'Spicy Shawarma') {
      imagePath = "assets/shawarma.jpg";
    }

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
                    item['title'] == 'Chicken Burger'
                        ? Colors.amber
                        : item['title'] == 'Onion Pizza'
                        ? Colors.red.shade300
                        : Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Load More..',
        style: TextStyle(
          color: Color(0xFF25AE4B),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> item, String tab) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: Text(
            tab == "Cart"
                ? "Are you sure you want to delete ${item['title']} from your cart?"
                : "Are you sure you want to delete ${item['title']} from your history?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (tab == "Cart") {
                    cartItems.remove(item);
                  } else {
                    historyItems.remove(item);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
