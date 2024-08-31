import 'package:flutter/material.dart';

class TestimonialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.0), // Adjusted for top and bottom padding
      color: Color(0xFFEEF4F9), // Background color from HTML
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFFEEF4F9), // Background color from HTML
            ),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(
                  maxWidth: 1200.0), // Max width as per your design
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Qitaby is a game-changer for students in Lebanon! With their platform, buying and selling used school books has become effortless. The live price updates and the option to add books for sale or purchase make it even more convenient. Thank you, Qitaby, for making education more affordable!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111827), // Color from HTML
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Farah',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF111827), // Color from HTML
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
