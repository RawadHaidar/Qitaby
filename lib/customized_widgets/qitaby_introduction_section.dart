import 'package:flutter/material.dart';

class QitabyIntroductionSection extends StatelessWidget {
  const QitabyIntroductionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(238, 244, 249, 1.0), // Background color
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Padding top and bottom
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 1200), // Maximum width for content
            child: const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding left and right
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32), // Padding at the top
                  Text(
                    'Introducing Qitaby',
                    style: TextStyle(
                      color: Color.fromRGBO(17, 24, 39, 1.0),
                      fontSize: 35, // Font size for heading
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16), // Space between heading and text
                  Text(
                    'The ultimate online platform for buying and selling used school books in Lebanon. We understand that not everyone can afford the prices of new books, which is why Qitaby empowers individuals to connect and exchange their used books at affordable prices. Our website provides real-time updates on book prices, ensuring transparency and convenience for all users. With Qitaby, Lebanon\'s education system will thrive as students and parents can easily access and trade the books they need. Join Qitaby today and unlock a world of affordable educational resources at your fingertips.',
                    style: TextStyle(
                      color: Color.fromRGBO(17, 24, 39, 1.0),
                      fontSize: 22, // Font size for body text
                      height: 1.5, // Line height
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
