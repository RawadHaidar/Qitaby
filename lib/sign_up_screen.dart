import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qitaby_web/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

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
        return AlertDialog(
          // title: Text('Confirm Sign Up'),
          content: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Welcome to our online platform dedicated to buying and selling school books within Beirut, Lebanon. \n\n',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: 'Privacy Information Notice: \n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Please note that by choosing to sell or share your books on our platform, your phone number and profile information will be visible to other users, this enables seamless communication between buyers and sellers, ensuring a smooth transaction process. We prioritize your privacy and encourage users to connect responsibly.',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _performSignUp(); // Call the sign-up function
              },
              child: const Text('Accept'),
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

        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        print('Error: $e');
        // Handle any errors here if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
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
                    return 'Please enter a valid 8-digit phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _retypePasswordController,
                decoration: const InputDecoration(labelText: 'Retype Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please retype your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _showConfirmationDialog, // Show confirmation dialog
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
