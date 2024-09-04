import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/language_provider.dart';

class QitabyIntroductionSection extends StatelessWidget {
  const QitabyIntroductionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Container(
      color: Color.fromRGBO(238, 244, 249, 1.0), // Background color
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Padding top and bottom
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 1200), // Maximum width for content
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding left and right
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32), // Padding at the top
                  Text(
                    currentLanguage == 'en'
                        ? 'Introducing Qitaby'
                        : 'Présentation de Qitaby',
                    style: const TextStyle(
                      color: Color.fromRGBO(17, 24, 39, 1.0),
                      fontSize: 35, // Font size for heading
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16), // Space between heading and text
                  Text(
                    currentLanguage == 'en'
                        ? 'The ultimate online platform for buying and selling used school books in Lebanon. We understand that not everyone can afford the prices of new books, which is why Qitaby empowers individuals to connect and exchange their used books at affordable prices. Our website provides real-time updates on book prices, ensuring transparency and convenience for all users. With Qitaby, Lebanon\'s education system will thrive as students and parents can easily access and trade the books they need. Join Qitaby today and unlock a world of affordable educational resources at your fingertips.'
                        : 'La plateforme en ligne par excellence pour l’achat et la vente de livres scolaires d’occasion au Liban. Nous comprenons que tout le monde ne peut pas se permettre les prix des livres neufs, c’est pourquoi Qitaby permet aux particuliers de se connecter et d’échanger leurs livres usagés à des prix abordables. Notre site Web fournit des mises à jour en temps réel sur les prix des livres, assurant ainsi transparence et commodité pour tous les utilisateurs. Avec Qitaby, le système éducatif libanais prospérera car les élèves et les parents pourront facilement accéder aux livres dont ils ont besoin et les échanger. Rejoignez Qitaby dès aujourd’hui et débloquez un monde de ressources éducatives abordables à portée de main.',
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
