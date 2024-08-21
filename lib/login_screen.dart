import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up_screen.dart'; // Import the SignUpScreen

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errormessage = '';

  void _signIn() async {
    try {
      // Sign in the user
      await _auth.signInWithEmailAndPassword(
        email: "+961${_phoneNumberController.text}@example.com",
        password: _passwordController.text,
      );

      // Navigate to the home screen or show success message
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
      MaterialPageRoute(
          builder: (context) => SignUpScreen()), // Navigate to SignUpScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
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
            Text(style: TextStyle(color: Colors.red), "$errormessage"),
          ],
        ),
      ),
    );
  }
}
