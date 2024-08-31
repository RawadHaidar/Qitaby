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
  String? selectedMaterial;
  List<String> schoolNames = [];
  String? errorMessage;

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

    _fetchUserData();
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
        selectedStatus == null ||
        selectedMaterial == null) {
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
      material: selectedMaterial!,
      username: username ?? 'Anonymous',
      usernumber: userNumber ?? 'Unknown',
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
    String? email = authService.currentUser?.email;
    String phonenumber =
        (email != null && email.length >= 13) ? email.substring(0, 12) : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Book',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        elevation: 4.0,
        toolbarHeight: 80.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return [
                    'Mathematics',
                    'Physics',
                    'Biology',
                    'Chemistry',
                    'French (language)',
                    'English (language)',
                    'اللغة العربية',
                    'التربية الوطنية والتنشئة المدنية',
                    'التاريخ',
                    'الجغرافيا',
                    'Other'
                  ].where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    selectedMaterial = selection;
                  });
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Select Material',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
                displayStringForOption: (String option) => option,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Book Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _gradeController,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Your Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              Autocomplete<String>(
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
                    decoration: const InputDecoration(
                      labelText: 'Select School Name',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
                displayStringForOption: (String option) => option,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                hint: const Text('Select Book Condition'),
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
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Add Book',
                    style: TextStyle(color: Colors.white)),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 10.0),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
