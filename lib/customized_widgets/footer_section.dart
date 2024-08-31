import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF21392A), // Background color from HTML
      padding:
          EdgeInsets.symmetric(vertical: 12.0), // Padding for top and bottom
      child: Center(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: 1200.0), // Max width for container
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Section
                  Row(
                    children: [
                      Image.asset(
                        'assets/logo/137857-200.png',
                        width: 50,
                        height: 50,
                        color: const Color.fromARGB(255, 216, 236, 226),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Qitaby',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 29.88, // Font size from HTML
                          fontWeight:
                              FontWeight.bold, // Adjust as per your design
                          fontFamily:
                              'HeaderLogoFontFamily', // Adjust as per your design
                        ),
                      ),
                    ],
                  ),
                  // Navigation Links
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {}, // Add navigation logic
                            child: const Text(
                              'Shop',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          TextButton(
                            onPressed: () {}, // Add navigation logic
                            child: const Text(
                              'Log In or Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'Made with',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Add navigation logic
                        },
                        child: const Text(
                          'Flutter',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
