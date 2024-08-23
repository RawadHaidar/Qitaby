import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';
import 'book_service.dart';
import 'auth_service.dart';

class AddBookScreen extends StatefulWidget {
  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? selectedSchoolName;
  String? selectedStatus;
  List<String> schoolNames = [];
  String? errorMessage;

  // Declare the variables to hold the user data
  String? username;
  String? userNumber;
  String? userAddress;

  @override
  void initState() {
    super.initState();
    BookService().fetchSchoolNames().then((names) {
      setState(() {
        schoolNames = names;
      });
    });

    _fetchUserData(); // Fetch user data on initialization
  }

  Future<void> _fetchUserData() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        setState(() {
          username = userData['username'];
          userNumber = userData['phone_number'];
          userAddress = userData['address'];
        });
      }
    }
  }

  void _addBook() async {
    if (_nameController.text.isEmpty ||
        _gradeController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _priceController.text.isEmpty ||
        selectedSchoolName == null ||
        selectedStatus == null) {
      setState(() {
        errorMessage = 'Please fill out all fields';
      });
      return;
    }

    final book = Book(
      id: DateTime.now().toString(),
      name: _nameController.text,
      schoolName: selectedSchoolName!,
      grade: _gradeController.text,
      userAddress: userAddress ?? _addressController.text,
      price: double.parse(_priceController.text),
      status: selectedStatus!,
      username: username ?? 'Anonymous', // Use fetched or fallback value
      usernumber: userNumber ?? 'Unknown', // Use fetched or fallback value
    );

    try {
      await Provider.of<BookService>(context, listen: false).addBook(book);
      setState(() {
        errorMessage = null;
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        errorMessage = 'Error adding book: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // String? user = authService.currentUser?.phoneNumber;
    String? email = authService.currentUser?.email;
    String phonenumber =
        (email != null && email.length >= 13) ? email.substring(0, 12) : '';

    return Scaffold(
      appBar: AppBar(title: Text('Add Book')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Book Name'),
            ),
            TextField(
              controller: _gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return schoolNames.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    selectedSchoolName = selection;
                  });
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Select School Name',
                    ),
                  );
                },
                displayStringForOption: (String option) => option,
              ),
            ),
            DropdownButton<String>(
              value: selectedStatus,
              hint: Text('Select Status'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
              items: ['Excellent', 'Good', 'Bad']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addBook,
              child: Text('Adding Book by $phonenumber'),
            ),
            if (errorMessage != null) ...[
              SizedBox(height: 10.0),
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
