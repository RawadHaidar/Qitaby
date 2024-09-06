import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/pages/home_page.dart';
import 'sign_up_screen.dart'; // Import the SignUpScreen

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errormessage = '';

  void _signIn() async {
    try {
      // Sign in the user
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error: $e');
      // Show error message to user
      setState(() {
        errormessage = e
            .toString()
            .replaceFirst('[firebase_auth/invalid-credential] ', '');
      });
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  // Function to send password reset email
  void _resetPassword() async {
    try {
      String email = _emailController.text;

      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email);

      // Show a message to inform the user that the password reset email was sent
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Password Reset'),
          content: const Text(
              'A password reset link has been sent to your email. Please check your inbox.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error: $e');
      setState(() {
        errormessage = e
            .toString()
            .replaceFirst('[firebase_auth/invalid-credential] ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Login',
              textAlign: TextAlign.left,
              style: GoogleFonts.alata(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(18, 41, 27, 1.0), // White text color
                  fontSize: 25, // Heading large size
                  fontWeight: FontWeight.bold, // Bold weight for emphasis
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _navigateToSignUp,
              child: const Text('Don\'t have an account? Sign Up'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resetPassword, // Reset password button
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 20),
            Text(
              style: const TextStyle(color: Colors.red),
              errormessage,
            ),
          ],
        ),
      ),
    );
  }
}
