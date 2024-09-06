import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_wrapper_toshop.dart';
import 'package:qitaby_web/language_provider.dart';

class RecycleBooksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return SingleChildScrollView(
      child: Container(
        // height: 600, // Adjust the height as needed
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://cdn.durable.co/shutterstock/2a7QnTAPcXnG53gGMO1sf9lh3FyucJT515hTW7mXsnNoVM8bm0ITY069ZCxfuT6Y.jpeg', // URL of the background image
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color:
                  Color.fromRGBO(33, 57, 42, 0.7), // Semi-transparent overlay
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentLanguage == 'en'
                          ? 'Recycle Books, Enrich Minds'
                          : 'Recycler les livres, enrichir les esprits',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 40, // Adjust font size as needed
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentLanguage == 'en'
                          ? 'Join the communal effort to buy and sell affordable used school books in Lebanon.'
                          : 'Rejoignez l’effort communautaire pour acheter et vendre des livres scolaires d’occasion à des prix abordables au Liban.',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25, // Adjust font size as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200, // Adjust the width of the button as needed
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
                          backgroundColor: const Color.fromRGBO(
                              245, 223, 178, 1.0), // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Color.fromRGBO(
                                  245, 223, 178, 1.0), // Button border color
                              width: 2.0,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          currentLanguage == 'en'
                              ? 'Start Saving'
                              : 'Commencez à économiser',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(17, 24, 39, 1.0),
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
    );
  }
}
