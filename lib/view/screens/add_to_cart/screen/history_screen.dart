import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoadingMore = false;
  bool _hasMoreHistory = true;

  // Data for history
  List<Map<String, dynamic>> historyItems = [
    {
      'name': 'Pizza',
      'description': 'Just added',
      'price': '\$12',
      'image': 'assets/images/Empty-amico.png',
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    },
    {
      'name': 'Pasta',
      'description': 'Just added',
      'price': '\$12',
      'image': 'assets/images/Empty-amico.png',
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar2(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all( 10.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          ),
          _buildHistoryContent(),
        ],
      ),
    );
  }

  Widget _buildHistoryContent() {
    if (historyItems.isEmpty && !_isLoadingMore) {
      return _buildEmptyState(
        'History Empty',
        'You don\'t have any order history',
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => SizedBox(height: 16),
        itemCount: historyItems.length + 1, // +1 for Load More widget
        itemBuilder: (context, index) {
          if (index == historyItems.length) {
            return _buildLoadMoreWidget();
          }
          return _buildHistoryItem(historyItems[index], index);
        },
      ),
    );
  }

  Widget _buildLoadMoreWidget() {
    if (!_hasMoreHistory) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('No more orders', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: _isLoadingMore
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        )
            : GestureDetector(
          onTap: _loadMoreHistory,
          child: Text(
            'Load More...',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMoreHistory() async {
    if (_isLoadingMore || !_hasMoreHistory) return;

    setState(() {
      _isLoadingMore = true;
    });

    // Simulating network delay
    await Future.delayed(Duration(seconds: 2));

    final newItems = [
      {
        'name': 'Pizza ${historyItems.length + 1}',
        'description': 'Just added',
        'price': '\$12',
        'image': 'assets/images/Empty-amico.png',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
      {
        'name': 'Pasta ${historyItems.length + 2}',
        'description': 'Just added',
        'price': '\$12',
        'image': 'assets/images/Empty-amico.png',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
    ];

    setState(() {
      historyItems.addAll(newItems);
      _isLoadingMore = false;
      _hasMoreHistory = historyItems.length < 10; // Example: stop after 10 items
    });
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Image.asset(
            'assets/images/Empty-amico.png',
            width: 280,
            height: 280,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['name'] + item['date']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.orange,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeHistoryItem(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item['description'],
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['price'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      item['date'],
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    _reorderItem(item);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.replay, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Reorder',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeHistoryItem(int index) {
    final removedItem = historyItems[index];
    setState(() {
      historyItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem['name']} removed from history'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              historyItems.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  }

  void _reorderItem(Map<String, dynamic> item) {
    setState(() {
      // Add item to cart (Cart logic not included here)
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to cart')),
    );
  }
}
