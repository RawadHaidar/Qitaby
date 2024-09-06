import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_wrapper.dart';
import 'package:qitaby_web/auth_wrapper_toshop.dart';
import 'package:qitaby_web/language_provider.dart';

class BuySellBooksSection extends StatefulWidget {
  @override
  _BuySellBooksSectionState createState() => _BuySellBooksSectionState();
}

class _BuySellBooksSectionState extends State<BuySellBooksSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Start the animation when the widget is first built
    Future.delayed(Duration.zero, () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(33, 57, 42, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      245, 223, 178, 0.1), // Light background color
                  borderRadius: BorderRadius.circular(20), // Rounded edges
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 60.0, horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedSlide(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeOut,
                        offset: _isVisible ? Offset(0, 0) : Offset(0, 0.3),
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                          opacity: _isVisible ? 1.0 : 0.0,
                          child: Text(
                            currentLanguage == 'en'
                                ? 'Buy and Sell Used Books'
                                : 'Acheter et vendre des livres d’occasion',
                            style: GoogleFonts.alata(
                              textStyle: const TextStyle(
                                color: Colors.white, // White text color
                                fontSize: 36, // Heading large size
                                fontWeight:
                                    FontWeight.bold, // Bold weight for emphasis
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedSlide(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeOut,
                        offset: _isVisible ? Offset(0, 0) : Offset(0, 0.3),
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                          opacity: _isVisible ? 1.0 : 0.0,
                          child: Text(
                            currentLanguage == 'en'
                                ? 'Find affordable school books or list yours for sale today.'
                                : 'Trouvez des livres scolaires abordables ou mettez le vôtre en vente dès aujourd’hui.',
                            style: GoogleFonts.alata(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle
                                    .normal, // Italic style for emphasis
                                color: Colors.white, // White text color
                                fontSize: 25, // Normal body text size
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AnimatedSlide(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeOut,
                        offset: _isVisible ? Offset(0, 0) : Offset(0, 0.3),
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeOut,
                          opacity: _isVisible ? 1.0 : 0.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigation logic to the new page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthWrapperToshop()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(245, 223,
                                  178, 1.0), // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  color: Color.fromRGBO(245, 223, 178,
                                      1.0), // Button border color
                                  width: 2.0,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 32.0),
                              shadowColor: Colors
                                  .transparent, // No shadow as per the style
                            ),
                            child: Text(
                              currentLanguage == 'en'
                                  ? 'Get Started'
                                  : 'Démarrer',
                              style: GoogleFonts.alata(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(17, 24, 39,
                                      1.0), // Dark button text color
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
