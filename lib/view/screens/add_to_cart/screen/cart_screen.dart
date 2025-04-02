import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';

import '../widget/categ.dart';
import '../widget/credat_card.dart';
import '../widget/menu.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: Appbar2(),
      body: Column(
        children: [
          SizedBox(height: 10),
          Categ (),
          SizedBox(height: 30),
          Expanded(
            child: MenuList(),
          ),
          SizedBox(height: 20),
          CredatCard(
            isCartEmpty: false,
          ),
          SizedBox(height: 20),



        ],
      ),
    );
  }
}
