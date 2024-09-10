import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';
import 'package:qitaby_web/pages/home_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? _signUpError; // Variable to hold the error message

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  bool _isVerificationEmailSent = false; // Track if email verification is sent
  bool _isVerifying = false; // Show loading indicator while checking email

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        final currentLanguage = languageProvider.currentLanguage;
        return AlertDialog(
          content: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: currentLanguage == 'en'
                      ? 'Welcome to our platform for buying and selling school books in Lebanon. \n\n'
                      : "Bienvenue sur notre plateforme d'achat et de vente de livres scolaires à Liban. \n\n",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: currentLanguage == 'en'
                      ? 'Privacy Information Notice: \n'
                      : 'Avis d’information sur la confidentialité: \n',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: currentLanguage == 'en'
                      ? 'By selling or sharing your books, your phone number and profile will be visible to others.'
                      : "En vendant ou partageant vos livres, votre numéro de téléphone et votre profil seront visibles.",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(currentLanguage == 'en' ? 'Cancel' : 'Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _performSignUp(); // Call the sign-up function
              },
              child: Text(currentLanguage == 'en' ? 'Accept' : "Accepter"),
            ),
          ],
        );
      },
    );
  }

  void _performSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create a new user
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Send email verification
        User? user = userCredential.user;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          setState(() {
            _isVerificationEmailSent = true;
          });
          // Start monitoring email verification
          _monitorEmailVerification(user);
        }
      } catch (e) {
        setState(() {
          _signUpError = 'Error: $e'; // Set error message
        });
      }
    }
  }

  void _monitorEmailVerification(User user) async {
    setState(() {
      _isVerifying = true;
    });

    // Check every 3 seconds if the email is verified
    while (!user.emailVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user.reload(); // Reload user to get latest info
      user = _auth.currentUser!;
    }

    setState(() {
      _isVerifying = false;
    });

    // If the email is verified, save user data to Firestore
    await _firestore.collection('users').doc(user.uid).set({
      'username': _usernameController.text,
      'address': _addressController.text,
      'email': _emailController.text,
      'phone_number': _phoneNumberController.text,
      'rating': 'Not rated',
      'type': 'Regular user',
      'uid': user.uid
    });

    // Clear any previous error message
    setState(() {
      _signUpError = null;
    });

    // Navigate to the home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                currentLanguage == 'en' ? 'Sign Up' : 'S’inscrire',
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(18, 41, 27, 1.0),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: currentLanguage == 'en'
                        ? 'Username'
                        : 'Nom d’utilisateur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return currentLanguage == 'en'
                        ? 'Please enter your username'
                        : 'Veuillez entrer votre nom d’utilisateur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: currentLanguage == 'en' ? 'Address' : 'Adresse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return currentLanguage == 'en'
                        ? 'Please enter your address'
                        : "Veuillez entrer votre adresse";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: currentLanguage == 'en'
                        ? 'Email Address'
                        : 'Adresse Courriel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return currentLanguage == 'en'
                        ? 'Please enter your Email Address'
                        : "Veuillez entrer votre Adresse Courriel";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: currentLanguage == 'en'
                      ? 'Phone Number'
                      : 'Numéro de téléphone',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  _phoneNumberController.value = TextEditingValue(
                    text: '+961${value.replaceAll('+961', '')}',
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: value.length + 4),
                    ),
                  );
                },
                validator: (value) {
                  if (value == null ||
                      value.length != 12 ||
                      !RegExp(r'^\+961\d{8}$').hasMatch(value)) {
                    return currentLanguage == 'en'
                        ? 'Please enter a valid 8-digit phone number'
                        : 'Veuillez saisir un numéro de téléphone valide à 8 chiffres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText:
                        currentLanguage == 'en' ? 'Password' : 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return currentLanguage == 'en'
                        ? 'Please enter your password'
                        : 'Veuillez entrer votre mot de passe';
                  } else if (value.length < 8) {
                    return currentLanguage == 'en'
                        ? 'Password must be at least 8 characters long'
                        : 'Le mot de passe doit comporter au moins 8 caractères';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _retypePasswordController,
                decoration: InputDecoration(
                    labelText: currentLanguage == 'en'
                        ? 'Retype Password'
                        : 'Retaper le mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return currentLanguage == 'en'
                        ? 'Please retype your password'
                        : 'Veuillez retaper votre mot de passe';
                  }
                  if (value != _passwordController.text) {
                    return currentLanguage == 'en'
                        ? 'Passwords do not match'
                        : 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: _showConfirmationDialog,
                child: const Text('Sign Up'),
              ),
              if (_isVerificationEmailSent)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'A verification email has been sent to your email address. Please verify and sign in.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                      if (_isVerifying)
                        const CircularProgressIndicator(), // Show loader while checking verification
                    ],
                  ),
                ),
              if (_signUpError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _signUpError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
