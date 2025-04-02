import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../screen/cart_screen.dart';
import '../screen/history_screen.dart';

class Categ extends StatefulWidget {
  @override
  State<Categ> createState() => _CategState();
}

class _CategState extends State<Categ> {
  String selectedButton = ''; // Track which button is selected

  void _onButtonPressed(String text) {
    setState(() {
      selectedButton = text;


    });

    // Navigate to the respective screen
    if (text == 'Cart') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartScreen()),
      );
    } else if (text == 'History') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HistoryScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          //mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            _buildButton('Cart'),
            SizedBox(width: 1), // Space between buttons
            _buildButton('History'),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text , ) {
    bool isSelected = selectedButton == text;

    return GestureDetector(
      onTap: () => _onButtonPressed(text),
      child: Container(
        width: 193,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2.5,
              color: isSelected ? Colors.green : Color(0xFFF5F5F5),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              textBaseline: TextBaseline.alphabetic,
              color: isSelected ? Colors.green : Color(0xFF98A0B4),
            ),
          ),
        ),
      ),
    );
  }
}
