import 'package:flutter/material.dart';

class AffordableBooksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.0), // Adjusted for top and bottom padding
      color: Color(0xFF12291B), // Background color from HTML
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color(0xFF12291B), // Background color from HTML
            ),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: 1200.0), // Max width as per your design
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Discover affordable school books',
                    style: TextStyle(
                      fontSize:
                          32.0, // Adjusted font size to match 'heading-xlarge'
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color from HTML
                    ),
                    textAlign: TextAlign.center,
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
