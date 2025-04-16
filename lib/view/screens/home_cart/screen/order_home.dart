import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodtec/view/widget/custom_app_bar.dart';
import '../../../../core/screen_index.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../widget/custom_primary_button.dart';


class OrderHome extends StatefulWidget {
  const OrderHome({super.key});

  @override
  State<OrderHome> createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  double spicyLevel = 5.0;
  int quantity = 1;
  String itemName = 'Cheeseburger Wendy';
  String imagePath = 'assets/images/TakeAway.png';
  double rating = 4.5;
  int reviews = 89;
  double price = 7.99;
  double oldPrice = 9.5;
  String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eget.'
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eget.'
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eget.'
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eget.';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 203,
                  width: 370,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                height: 95,
                width: 390,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) =>
                              Icon(Icons.star, color: Colors.orange),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(width: 5),
                        Text('$rating ($reviews reviews)')
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)} ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '\$${oldPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 75,
                width: 380,
                child: Text(
                  description,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 79,
                width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Spicy'),
                        Row(
                          children: [
                            Text('Mild'),
                            Slider(
                              value: spicyLevel,
                              onChanged: (value) {
                                setState(() {
                                  spicyLevel = value;
                                });
                              },
                              min: 0,
                              max: 10,
                              activeColor: Colors.red,
                            ),
                            Text('Hot'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Quantity'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 34),
              Center(
                child: CustomPrimaryButton(
                  text: 'Add to Cart',
                  onTap: () {
                    context.read<NavigationCubit>().goTo(ScreenIndex.CheckoutScreen);

                    // Add to cart logic here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
