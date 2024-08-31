import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/aboutus.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/search_book_screen.dart';
import 'package:qitaby_web/profile_screen.dart';
import 'package:qitaby_web/add_book_screen.dart';
import 'package:qitaby_web/main.dart'; // Update with the correct import for the home screen or wrapper

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final bool isSignedIn = authService.currentUser != null;

    return Scaffold(
      backgroundColor:
          Color(0xFF18291B), // Dark green background similar to the HTML
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Color(0xFF18291B), // Matching AppBar color
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
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
            SizedBox(height: 24.0),
            // Menu Items
            Expanded(
              child: ListView(
                children: isSignedIn
                    ? [
                        _buildMenuItem(context, title: 'User Profile',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                        }),
                        _buildMenuItem(context, title: 'Shop', onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBookScreen()),
                          );
                        }),
                        _buildMenuItem(context, title: 'Sell a Book',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBookScreen()),
                          );
                        }),
                        _buildMenuItem(context, title: 'Home', onPressed: () {
                          Navigator.pop(
                              context); // Close menu or navigate to Home
                        }),
                        _buildMenuItem(context, title: 'About Us',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage()),
                          );
                        }),
                        _buildMenuItem(context, title: 'Logout',
                            onPressed: () async {
                          await authService.signOut();
                          Navigator.pop(
                              context); // Close menu or navigate to Home
                        }),
                      ]
                    : [
                        _buildMenuItem(context, title: 'Home', onPressed: () {
                          Navigator.pop(
                              context); // Close menu or navigate to Home
                        }),
                        _buildMenuItem(context, title: 'About Us',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage()),
                          );
                        }),
                        _buildMenuItem(context, title: 'Log In or Sign Up',
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthWrapper()),
                          ); // Update with the correct route for authentication
                        }),
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
