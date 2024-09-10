import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.dark),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentLanguage == 'en'
                    ? 'Welcome to our school book marketplace!'
                    : 'Bienvenue sur notre marché de livres scolaires!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                currentLanguage == 'en'
                    ? 'Your one-stop platform for buying and selling school books in Lebanon, Lebanon. '
                        'We understand the challenges that students and parents face when it comes to finding '
                        'affordable and accessible educational resources. That\'s why we created this platform—to make '
                        'the process of obtaining school books easier, more affordable, and more sustainable.'
                    : ' Votre plateforme unique d’achat et de vente de livres scolaires à Liban. '
                        'Nous comprenons les défis auxquels les élèves et les parents sont confrontés lorsqu’il s’agit de trouver'
                        'Des ressources éducatives abordables et accessibles. C’est pourquoi nous avons créé cette plate-forme - pour faire en sorte que '
                        'Le processus d’obtention de livres scolaires est plus facile, plus abordable et plus durable.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[800], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                currentLanguage == 'en' ? 'Our Mission' : 'Notre mission',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                currentLanguage == 'en'
                    ? 'Our mission is to connect students, parents, and educators across Lebanon with the books '
                        'they need for their academic journey. Whether you\'re looking to buy or sell new or used school books, '
                        'our platform offers a convenient and user-friendly experience that ensures everyone has access to the materials they need for success.'
                    : 'Notre mission est de connecter les élèves, les parents et les éducateurs de Liban avec les livres'
                        'Ils ont besoin pour leur parcours scolaire. Que vous cherchiez à acheter ou à vendre des livres scolaires neufs ou d’occasion,'
                        'Notre plateforme offre une expérience pratique et conviviale qui garantit que chacun a accès au matériel dont il a besoin pour réussir.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[800], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                currentLanguage == 'en' ? 'How It Works' : 'Comment ça marche',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                currentLanguage == 'en'
                    ? '- Buy: Browse our extensive collection of school books from various sellers. '
                        'Use our search and filter options to find exactly what you need based on book title, school name, or grade level.\n\n'
                        '- Sell: Have extra books from last year? Easily list them on our platform for others to buy. '
                        'It’s a great way to declutter and help others in the community.'
                    : '- Acheter : Parcourez notre vaste collection de livres scolaires de différents vendeurs. '
                        'Utilisez nos options de recherche et de filtrage pour trouver exactement ce dont vous avez besoin en fonction du titre du livre, du nom de l’école ou du niveau scolaire.\n\n'
                        '- Vendre : Vous avez des livres supplémentaires de l’année dernière ? Répertoriez-les facilement sur notre plateforme pour que d’autres puissent les acheter.'
                        'C’est un excellent moyen de désencombrer et d’aider les autres dans la communauté.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[800], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                currentLanguage == 'en'
                    ? 'Why Choose Us?'
                    : 'Pourquoi nous choisir?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                currentLanguage == 'en'
                    ? '- Community-Focused: We\'re rooted in Lebanon and focused on serving the local community, making it easier '
                        'to find books specific to schools in Lebanon.\n\n'
                        '- Sustainability: By buying and selling used books, you\'re contributing to a more sustainable environment '
                        'by reducing waste and promoting the reuse of resources.\n\n'
                        '- Affordability: Our platform helps you save money by offering a wide range of book prices, including more affordable used options.'
                    : '- Axé sur la communauté : Nous sommes enracinés à Liban et nous nous concentrons sur le service à la communauté locale, ce qui facilite la tâche'
                        'pour trouver des livres spécifiques aux écoles au Liban.\n\n'
                        '- Durabilité : En achetant et en vendant des livres d’occasion, vous contribuez à un environnement plus durable'
                        'en réduisant les déchets et en favorisant la réutilisation des ressources.\n\n'
                        '- Accessibilité : notre plateforme vous aide à économiser de l’argent en proposant une large gamme de prix de livres, y compris des options d’occasion plus abordables.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[800], // Adjust color to match the theme
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                currentLanguage == 'en'
                    ? 'Join us in creating a more connected and resourceful educational community in Lebanon. '
                        'Together, we can ensure that every student has the tools they need to succeed!'
                    : 'Rejoignez-nous pour créer une communauté éducative plus connectée et plus débrouillarde à Liban. '
                        'Ensemble, nous pouvons faire en sorte que chaque élève dispose des outils dont il a besoin pour réussir !',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[800], // Adjust color to match the theme
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.green[50], // Light background color
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsPage(),
  ));
}
