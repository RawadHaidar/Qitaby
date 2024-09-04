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
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

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
                      ? 'Welcome to our online platform dedicated to buying and selling school books within Beirut, Lebanon. \n\n'
                      : "Bienvenue sur notre plateforme en ligne dédiée à l'achat et à la vente de livres scolaires à Beyrouth, au Liban. \n\n",
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
                      ? 'Please note that by choosing to sell or share your books on our platform, your phone number and profile information will be visible to other users. This enables seamless communication between buyers and sellers, ensuring a smooth transaction process. We prioritize your privacy and encourage users to connect responsibly.'
                      : "Veuillez noter que si vous choisissez de vendre ou de partager vos livres sur notre plateforme, votre numéro de téléphone et les informations de votre profil seront visibles par les autres utilisateurs. Cela permet une communication transparente entre les acheteurs et les vendeurs, garantissant ainsi un processus de transaction fluide. Nous accordons la priorité à votre vie privée et encourageons les utilisateurs à se connecter de manière responsable.",
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
          email: "${_phoneNumberController.text}@example.com",
          password: _passwordController.text,
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'username': _usernameController.text,
          'address': _addressController.text,
          'phone_number': _phoneNumberController.text,
          'password': _passwordController.text,
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
      } catch (e) {
        setState(() {
          _signUpError = 'Error: $e'; // Set error message
        });
      }
    }
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
              const SizedBox(
                height: 10,
              ),
              Text(
                'Sign Up',
                textAlign: TextAlign.left,
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(18, 41, 27, 1.0), // White text color
                    fontSize: 25, // Heading large size
                    fontWeight: FontWeight.bold, // Bold weight for emphasis
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
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
                      TextPosition(
                          offset: value.length + 4), // Adjust offset as needed
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
              ElevatedButton(
                onPressed: _showConfirmationDialog, // Show confirmation dialog
                child: const Text('Sign Up'),
              ),
              if (_signUpError != null) // Display error message
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
