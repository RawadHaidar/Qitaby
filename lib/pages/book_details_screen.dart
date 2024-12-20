import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              currentLanguage == 'en' ? 'Book Details' : 'Détails du livre',
              textAlign: TextAlign.left,
              style: GoogleFonts.alata(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(18, 41, 27, 1.0), // Dark green color
                  fontSize: 25, // Heading large size
                  fontWeight: FontWeight.bold, // Bold weight for emphasis
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              book.name,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Condition: ${book.condition}',
              style: const TextStyle(fontSize: 18.0),
            ),

            const SizedBox(height: 8.0),
            Text(
              currentLanguage == 'en'
                  ? 'Material: ${book.material}'
                  : 'Matiére: ${book.material}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Class: ${book.grade}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              currentLanguage == 'en'
                  ? 'School: ${book.schoolName}'
                  : 'École: ${book.schoolName}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),

            // Display the publisher information
            Text(
              currentLanguage == 'en'
                  ? 'Publisher: ${book.publisher}'
                  : 'Edition: ${book.publisher}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            // Display the year of publication information
            Text(
              currentLanguage == 'en'
                  ? 'Year of Publication: ${book.yearOfPublication}'
                  : 'Année de publication: ${book.yearOfPublication}',
              style: const TextStyle(fontSize: 18.0),
            ),

            const SizedBox(height: 8.0),
            Text(
              currentLanguage == 'en'
                  ? 'Owner: ${book.username.toString()}'
                  : 'Propriétaire: ${book.username.toString()}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              currentLanguage == 'en'
                  ? 'Phone Number: ${book.usernumber.toString()}'
                  : 'Numéro de téléphone: ${book.usernumber.toString()}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              currentLanguage == 'en'
                  ? 'Price: ${book.price.toString()} USD'
                  : 'Prix: ${book.price.toString()} USD',
              style: const TextStyle(fontSize: 18.0),
            ),
            const Spacer(),
            Text(
              currentLanguage == 'en'
                  ? 'Disclaimer: This platform is not responsible for any defects, wear, or damage to the books listed for sale. Buyers are encouraged to carefully review the condition of the book before completing a purchase. All transactions are solely between the buyer and seller.'
                  : "Avis de non-responsabilité : Cette plateforme n’est pas responsable des défauts, de l’usure ou des dommages causés aux livres mis en vente. Les acheteurs sont encouragés à examiner attentivement l’état du livre avant de finaliser un achat. Toutes les transactions se font uniquement entre l’acheteur et le vendeur.",
              style: const TextStyle(fontSize: 14.0),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context); // Navigate back to the previous screen
            //   },
            //   child: Text(
            //     currentLanguage == 'en' ? 'Back' : 'Retour',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
