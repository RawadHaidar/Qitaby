import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_wrapper.dart';
import 'package:qitaby_web/customized_widgets/language_switch.dart';
import 'package:qitaby_web/language_provider.dart';
import 'package:qitaby_web/pages/aboutus.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/pages/home_page.dart';
import 'package:qitaby_web/pages/search_book_screen.dart';
import 'package:qitaby_web/pages/profile_screen.dart';
import 'package:qitaby_web/pages/add_book_screen.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final bool isSignedIn = authService.currentUser != null;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      backgroundColor:
          const Color(0xFF18291B), // Dark green background similar to the HTML
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          currentLanguage == 'en' ? 'Menu' : 'Menu',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF18291B), // Matching AppBar color
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Close the menu page
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 29.88,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HeaderLogoFontFamily',
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),
            // Menu Items
            Expanded(
              child: ListView(
                children: isSignedIn
                    ? [
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'User Profile'
                                : 'Profil de l’utilisateur', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'Shop'
                                : 'Boutique', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBookScreen()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'Sell a Book'
                                : 'Vendre un livre', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBookScreen()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en' ? 'Home' : 'Accueil',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'About Us'
                                : 'À propos de nous', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'Logout'
                                : 'Se déconnecter', onPressed: () async {
                          await authService.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentLanguage == 'en' ? 'Language' : 'Langue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            LanguageSwitch()
                          ],
                        ),
                      ]
                    : [
                        _buildMenuItem(context,
                            title: currentLanguage == 'en' ? 'Home' : 'Accueil',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'About Us'
                                : 'À propos de nous', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage()),
                          );
                        }),
                        _buildMenuItem(context,
                            title: currentLanguage == 'en'
                                ? 'Log In or Sign Up'
                                : 'Se connecter ou s’inscrire', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthWrapper()),
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentLanguage == 'en' ? 'Language' : 'Langue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            LanguageSwitch()
                          ],
                        ),
                      ],
              ),
            ),
            SizedBox(height: 24.0),
            // Footer
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String title, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF2A3A27), // Button background color
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
