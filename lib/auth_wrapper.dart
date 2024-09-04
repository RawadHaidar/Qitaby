import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:qitaby_web/auth_service.dart";
import "package:qitaby_web/pages/home_page.dart";
import "package:qitaby_web/pages/login_screen.dart";
import "package:qitaby_web/pages/search_book_screen.dart";

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? SignInScreen() : HomePage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
