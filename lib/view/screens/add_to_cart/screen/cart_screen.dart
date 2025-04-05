import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoadingMore = false;
  bool _hasMoreHistory = true;
  final int _historyPerPage = 2;
  String selectedTab = 'Cart';

  // بيانات السلة
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Pizza',
      'description': 'Just added',
      'price': '\$12',
      'image': 'assets/images/Empty-amico.png',
      'quantity': 1,
    },
    {
      'name': 'Pasta',
      'description': 'Just added',
      'price': '\$12',
      'image': 'assets/images/Empty-amico.png',
      'quantity': 1,
    }





  ];

  // بيانات التاريخ
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
          _buildTopTabs(),
          SizedBox(height: 10),
          Expanded(
            child:
                selectedTab == 'Cart'
                    ? _buildCartContent()
                    : _buildHistoryContent(),
          ),
          if (selectedTab == 'Cart' && cartItems.isNotEmpty)
            _buildCheckoutCard(),
        ],
      ),
    );
  }


  Widget _buildTopTabs() {
    return Row(

      children: [

        Expanded(child: _buildTabButton('Cart') ),

        Expanded(child: _buildTabButton('History')),
      ],
    );
  }


  Widget _buildTabButton(String tabName) {
    bool isSelected = selectedTab == tabName;

    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.5,
              color: isSelected ? Colors.green : Colors.grey[300]!,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            tabName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCartContent() {
    if (cartItems.isEmpty) {
      return _buildEmptyState(
        'Cart Empty',
        'You don\'t have any items in your cart',
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return _buildCartItem(cartItems[index], index);
      },
    );
  }

  // بناء محتوى التاريخ مع ميزة تحميل المزيد
  Widget _buildHistoryContent() {
    if (historyItems.isEmpty && !_isLoadingMore) {
      return _buildEmptyState(
        'History Empty',
        'You don\'t have any order history',
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, __) => SizedBox(height: 16),
      itemCount: historyItems.length + 1, // +1 لعنصر تحميل المزيد
      itemBuilder: (context, index) {
        if (index == historyItems.length) {
          return _buildLoadMoreWidget();
        }
        return _buildHistoryItem(historyItems[index], index);
      },
    );
  }

  // بناء ويدجت تحميل المزيد
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
        child:
            _isLoadingMore
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

    // محاكاة تأخير الشبكة
    await Future.delayed(Duration(seconds: 2));

    // في التطبيق الحقيقي، هنا ستجلب البيانات من API
    final newItems = [
      {
        'name': 'Pizza ${historyItems.length + 1}',
        'description': 'Just added',
        'price': '\$12',
        'image': 'assets/images/Empty-amico.png',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
      {
        'name': ' Pasta ${historyItems.length + 2}',
        'description': 'Just added',
        'price': '\$12',
        'image': 'assets/images/Empty-amico.png',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
    ];

    setState(() {
      historyItems.addAll(newItems);
      _isLoadingMore = false;
      _hasMoreHistory = historyItems.length < 10;
    });
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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


  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['name']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.orange,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeCartItem(index);
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

            // عناصر التحكم في الكمية
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFB0D3BA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove, size: 16, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (item['quantity'] > 1) {
                          item['quantity']--;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${item['quantity']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add, size: 16, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        item['quantity']++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
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


  void _removeCartItem(int index) {
    final removedItem = cartItems[index];
    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem['name']} removed from cart'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              cartItems.insert(index, removedItem);
            });
          },
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
      cartItems.add({
        'name': item['name'],
        'description': item['description'],
        'price': item['price'],
        'image': item['image'],
        'quantity': 1,
      });
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${item['name']} added to cart')));
  }


  Widget _buildCheckoutCard() {
    double subtotal = cartItems.fold(0, (sum, item) {
      return sum +
          (double.parse(item['price'].substring(1)) * item['quantity']);
    });
    double delivery = 5.0;
    double discount = 2.0;
    double total = subtotal + delivery - discount;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // ملخص الطلب
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery', '\$${delivery.toStringAsFixed(2)}'),
          _buildSummaryRow('Discount', '-\$${discount.toStringAsFixed(2)}'),
          Divider(color: Colors.white.withOpacity(0.5)),
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
          SizedBox(height: 16),

          // زر الدفع
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _placeOrder();
              },
              child: Text(
                'Place Order',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تنفيذ الطلب
  void _placeOrder() {
    setState(() {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);

      // نقل عناصر السلة إلى التاريخ
      for (var item in cartItems) {
        historyItems.insert(0, {
          'name': item['name'],
          'description': item['description'],
          'price': item['price'],
          'image': item['image'],
          'date': formattedDate,
        });
      }


      cartItems.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Order placed successfully!')));
  }


  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
