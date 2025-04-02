import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing intl package for date formatting

class OldOrdersPage extends StatefulWidget {
  @override
  _OldOrdersPageState createState() => _OldOrdersPageState();
}

class _OldOrdersPageState extends State<OldOrdersPage> {
  // List of menu items with mock data
  List<Map<String, String>> items = [
    {'name': 'Pizza', 'description': 'Delicious ', 'price': '\$10', 'image': 'assets/images/Sent_Message_rafiki 1.png'},
    {'name': 'Burger', 'description': 'Beef burger ', 'price': '\$7', 'image': 'assets/images/Sent_Message_rafiki 1.png'},
    // Add more initial items as needed
  ];
  bool isLoading = false;

  // Function to load more items
  void loadMoreItems() {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // Simulate a delay to mimic a network request or loading process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        items.addAll([
          {'name': 'Sushi', 'description': 'Fresh sushi', 'price': '\$15', 'image': 'assets/images/Sent_Message_rafiki 1.png'},
          {'name': 'Pasta', 'description': 'Italian pasta ', 'price': '\$12','image': 'assets/images/Sent_Message_rafiki 1.png'},
          // Add more items here
        ]);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Empty-amico.png'), // Image when the list is empty
          SizedBox(height: 30),
          Text(
            'History Empty',
            style: TextStyle(
              color: const Color(0xFF111827),
              fontSize: 32,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.30,
              letterSpacing: -0.64,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'You don’t have order any foods before',
            style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: -1, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    )
        : ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 18),
      itemCount: items.length + 1, // Add 1 for the "Load More" button
      itemBuilder: (context, index) {
        if (index == items.length) {
          return GestureDetector(
            onTap: loadMoreItems,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isLoading ? 'Loading...' : 'Load More..',
                style: TextStyle(
                  color: const Color(0xFF25AE4B),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Dismissible(
            key: Key(items[index]['name']!),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${items[index]['name']} removed')));
            },
            background: Container(
              color: Color(0xFFFDAC1D),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: OldOrders(
              name: items[index]['name']!,
              description: items[index]['description']!,
              price: items[index]['price']!,
              image: items[index]['image']!,
            ),
          );
        }
      },
    );
  }
}

class OldOrders extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  OldOrders({required this.name, required this.description, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d.M.yyyy').format(DateTime.now()); // Format current date

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 386,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        border: Border.all(color: Color(0xFFDBF4D1), width: 1.5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                image,
                width: 62,
                height: 62,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 3),
                      Text(
                        price,
                        style: TextStyle(fontSize: 19, color: Color(0xFF25AE4B)),
                      ),
                    ],
                  ),
                  SizedBox(width: 70),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 25, left: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 84,
                          height: 15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: Color.fromRGBO(37, 174, 75, 1),
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Color.fromRGBO(59, 59, 59, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 89,
                          height: 15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Color.fromRGBO(37, 174, 75, 1),
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Reorder',
                                style: TextStyle(
                                  color: Color.fromRGBO(37, 174, 75, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
