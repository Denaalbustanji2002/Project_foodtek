

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/widget/appbar2.dart';

import '../widget/categ.dart';
import '../widget/old_orders.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: Appbar2(),
        body: Column(
          children: [
            SizedBox(height: 10),
            Categ(),
            SizedBox(height: 30),
            Expanded(
              child: OldOrdersPage(),
            ),
          ],)
    );
  }
}