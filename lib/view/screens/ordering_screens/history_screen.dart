import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:foodtek_project/view/widgets/empty_widget.dart';
import '../../widgets/header_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      body: _buildHistoryContent(),
    );
  }

  Widget _buildHistoryContent() {
    if (historyItems.isEmpty) {
      return EmptyWidget(
        imagePath: "assets/images/empty.png",
        title: "History Empty",
        description: "You don't have any history at this time",
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ...historyItems.map((item) => _buildHistoryItem(item)).toList(),
          _buildLoadMoreButton(),
        ],
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
            onPressed: (context) => _showDeleteConfirmationDialog(context, item),
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
                            const Icon(Icons.access_time, size: 14, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(
                              item['date'],
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
        errorBuilder: (context, error, stackTrace) => Container(
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

  void _showDeleteConfirmationDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: Text("Are you sure you want to delete ${item['title']} from your history?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                setState(() {
                  historyItems.remove(item);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
