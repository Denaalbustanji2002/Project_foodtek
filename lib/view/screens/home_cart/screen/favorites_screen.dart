import 'package:flutter/material.dart';
import '../../../widget/app_bar1.dart';
import '../widget/remove_favorites.dart';


class FavoritesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const FavoritesScreen({super.key, required this.favoriteItems});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<bool> isFavoriteList = List.generate(10, (index) => false);

  Widget buildFoodGrid(List<Map<String, dynamic>> items) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 40,
          childAspectRatio: 0.7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildFoodCard(items[index], index);
        },
      ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['description'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['price'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Order Now',
                        style:
                        TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(item['image']),
                ),
              ),
              Positioned(
                top: -22,
                right: -10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffDBF4D1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavoriteList[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavoriteList[index]
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (isFavoriteList[index]) {
                        showNotificationDialog(
                          context,
                          'Remove Favorite',
                          'Are you sure you want to remove this item from favorites?',

                          onConfirm: () {
                            setState(() {
                              isFavoriteList[index] = false;
                              widget.favoriteItems.removeWhere(
                                      (favItem) => favItem['title'] == item['title']);
                            });
                          },
                        );
                      } else {
                        setState(() {
                          isFavoriteList[index] = true;
                          widget.favoriteItems.add(item);
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: widget.favoriteItems.isEmpty
            ? Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 300),
                Center(child: Text("No favorite items yet")),
              ],
            )
            : buildFoodGrid(widget.favoriteItems),
      ),
    );
  }
}
