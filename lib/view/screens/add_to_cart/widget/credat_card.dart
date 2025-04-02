import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredatCard extends StatelessWidget {
  final bool isCartEmpty; // Add a variable to check if the cart is empty

  const CredatCard({super.key, required this.isCartEmpty});

  @override
  Widget build(BuildContext context) {
    if (isCartEmpty) {
      return SizedBox.shrink(); // Return an empty widget if the cart is empty
    }

    return Column(
      children: [
        Stack(
          children: [
            // Container in the background
            Container(
              height: 206,
              width: 378,
              decoration: BoxDecoration(
                color: Color(0xFF25AE4B),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Positioned text elements on top of the container
            Positioned(
              top: 20, // Adjust the top positioning as needed
              left: 20,
              child: Text(
                'Sub-Total',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 40, // Adjust the top positioning as needed
              left: 20,
              child: Text(
                'Delivery Charge',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 60, // Adjust the top positioning as needed
              left: 20,
              child: Text(
                'Discount',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 90, // Adjust the top positioning as needed
              left: 20,
              child: Text(
                'Total:',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.64,
                ),
              ),
            ),
            Positioned(
              top: 20, // Adjust the top positioning as needed
              right: 20,
              child: Text(
                '100 \$',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 40, // Adjust the top positioning as needed
              right: 20,
              child: Text(
                '10 \$',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 60, // Adjust the top positioning as needed
              right: 20,
              child: Text(
                '10 \$',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                ),
              ),
            ),
            Positioned(
              top: 90, // Adjust the top positioning as needed
              right: 20,
              child: Text(
                '110 \$',
                style: TextStyle(
                  color: const Color(0xFFFEFEFF),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.64,
                ),
              ),
            ),
            Positioned(
              top: 130, // Adjust this value as needed
              left: 20,
              // Adjust this value as needed
              child: Container(
                width: 340,
                height: 57,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEFEFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
                child: TextButton(
                  onPressed: () {
                    // Define the action when the button is pressed
                  },
                  child: Text(
                    'Place My Order',
                    style: TextStyle(
                      color: const Color(0xFF25AE4B), // Green text color
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40), // Added space after the container
      ],
    );
  }
}
