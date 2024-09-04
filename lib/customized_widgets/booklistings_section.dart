import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/language_provider.dart';

class BookListingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 30.0), // Adjusted for top and bottom padding
      color: Color(0xFFEEF4F9), // Background color from HTML
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color(0xFFEEF4F9), // Background color from HTML
            ),
          ),
          Center(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: 1200.0), // Max width for container
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentLanguage == 'en'
                              ? 'Convenient Book Listings'
                              : 'Listes de livres pratiques',
                          style: const TextStyle(
                            fontSize:
                                28.0, // Adjusted font size to match 'heading-xlarge'
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111828), // Text color from HTML
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          currentLanguage == 'en'
                              ? 'Easily buy and sell used school books in Lebanon through our user-friendly website. Add your own listings and find the books you need with ease.'
                              : 'Achetez et vendez facilement des livres scolaires d’occasion au Liban grâce à notre site Web convivial. Ajoutez vos propres annonces et trouvez facilement les livres dont vous avez besoin.',
                          style: TextStyle(
                            fontSize:
                                16.0, // Adjust font size to match paragraph text
                            color: Color(0xFF111828), // Text color from HTML
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 3 / 2, // Aspect ratio from HTML
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(16.0), // Rounded corners
                        child: Image.network(
                          'https://cdn.durable.co/shutterstock/17cmjWCNF45humlPxEhEzPpX5s8ynkZ4l6NlKPbQdpWxRbz0lGrtcsCAX9z9qyBf.jpeg',
                          fit: BoxFit.cover, // Fit image as cover
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
    );
  }
}
