import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/language_provider.dart';

class TestimonialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentLanguage == 'en'
                        ? 'Qitaby is a game-changer for students in Lebanon! With their platform, buying and selling used school books has become effortless. The live price updates and the option to add books for sale or purchase make it even more convenient. Thank you, Qitaby, for making education more affordable!'
                        : 'Qitaby change la donne pour les étudiants au Liban ! Grâce à leur plateforme, l’achat et la vente de livres scolaires d’occasion sont devenus sans effort. Les mises à jour des prix en direct et la possibilité d’ajouter des livres à la vente ou à l’achat le rendent encore plus pratique. Merci, Qitaby, de rendre l’éducation plus abordable !',
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
