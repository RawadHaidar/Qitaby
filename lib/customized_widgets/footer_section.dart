import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_wrapper.dart';
import 'package:qitaby_web/auth_wrapper_toshop.dart';
import 'package:qitaby_web/language_provider.dart';

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
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
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Section
                  Column(
                    children: [
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthWrapperToshop()),
                              );
                            }, // Add navigation logic
                            child: Text(
                              currentLanguage == 'en' ? 'Shop' : 'Boutique',
                              style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => AuthWrapper()),
                          //     );
                          //   }, // Add navigation logic
                          //   child: const Text(
                          //     'Log In or Sign Up',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       decoration: TextDecoration.underline,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // Navigation Links
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 12.0),
                      Text(
                        currentLanguage == 'en' ? 'Made with' : 'Fait avec',
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
