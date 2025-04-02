import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  // List of menu items with mock data
  final List<Map<String, String>> items = [
    {'name': 'Chicken Burger','description': 'Burger Factory LTD', 'price': '\$20', 'image': 'assets/images/TakeAway.png'},
    {'name': 'Cheese Burger','description': 'Burger Factory LTppD', 'price': '\$18', 'image': 'assets/images/TakeAway.png'},
    {'name': 'Veggie Burger', 'description': 'Burger Factory LTD','price': '\$15', 'image': 'assets/images/TakeAway.png'},

  ];

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset('assets/images/Empty-amico.png'), // الصورة التي ستظهر عندما تكون القائمة فارغة
          SizedBox(height: 30),
          Text(
            'Cart Empty',
            style: TextStyle(
              color: const Color(0xFF111827) /* Headline */,
              fontSize: 32,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.30,
              letterSpacing: -0.64,
            ),
          ),
          SizedBox(height: 10),

          Text(
            'You don’t have add any foods in cart at this time ',
            style: TextStyle(fontSize: 16, color: Colors.grey , letterSpacing: -1, fontWeight:FontWeight.w500),
          ),
          //Spacer(),
        ],
      ),

    )
        : ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index]['name']!), // Use a unique key for each item
          direction: DismissDirection.endToStart, // Only allow swipe to the right
          onDismissed: (direction) {
            // Logic for removing the item from the list
            items.removeAt(index);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${items[index]['name']} removed')));
          },
          background: Container(
            color: Colors.orange, // Background color when swiped
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Menu1Widget(
            name: items[index]['name']!,
            description: items[index]['description']!,
            price: items[index]['price']!,
            image: items[index]['image']!,
          ),
        );
      },
    );
  }
}

class Menu1Widget extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  Menu1Widget({required this.name, required this.description, required this.price, required this.image});

  @override
  _Menu1WidgetState createState() => _Menu1WidgetState();
}

class _Menu1WidgetState extends State<Menu1Widget> {
  int quantity = 1; // Initial quantity

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: 386,
      height: 103,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        border: Border.all(color: Color(0xFFDBF4D1), width: 1.5),
      ),
      child: Row(
        children: [
          // Item Image
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                widget.image,
                width: 62,
                height: 62,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Item Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.price,
                    style: TextStyle(fontSize: 19, color: Color(0xFF25AE4B)),
                  ),
                ],
              ),
            ),
          ),

          // Quantity Selector
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // Decrease Button
                _buildIconButton(Icons.remove, _decrement, color: Color(0xFFB0D3BA)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$quantity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),

                // Increase Button
                _buildIconButton(Icons.add, _increment, color: Color(0xFF25AE4B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed, {required Color color}) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero, // Removing default padding
        constraints: BoxConstraints(), // Preventing icon expansion
        splashColor: Colors.transparent, // Removing splash effect
        highlightColor: Colors.transparent, // Removing highlight effect
      ),
    );
  }
}
