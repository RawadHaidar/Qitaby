import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/book_service.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/customized_widgets/grade_input_field.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';

class AddBookScreen extends StatefulWidget {
  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  String? selectedSchoolName;
  String? selectedcondition;
  String? selectedMaterial;
  List<String> schoolNames = [];
  String? errorMessage;

  String? username;
  String? userNumber;
  String? userAddress;
  String? uid;
  String? utype;

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
      uid = user.uid;
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        setState(() {
          username = userData['username'];
          userNumber = userData['phone_number'];
          userAddress = userData['address'];
          utype = userData['type'];
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
        selectedcondition == null ||
        selectedMaterial == null ||
        _publisherController.text.isEmpty || // Check for empty publisher
        _yearController.text.isEmpty) {
      // Check for empty year
      setState(() {
        errorMessage = 'Please fill out all fields';
      });
      return;
    }
    final int? year =
        int.tryParse(_yearController.text); // Parse year as integer
    if (year == null) {
      setState(() {
        errorMessage = 'Invalid year of publication';
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
      condition: selectedcondition!,
      material: selectedMaterial!,
      username: username ?? 'Anonymous',
      usernumber: userNumber ?? 'Unknown',
      usertype: utype ?? 'Unkown user type',
      publisher: _publisherController.text, // Include publisher
      yearOfPublication: year, // Include year of publication
      userid: uid ?? 'Unknown uid',
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    String phonenumber =
        (email != null && email.length >= 13) ? email.substring(0, 12) : '';

    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                currentLanguage == 'en' ? 'Add Book' : 'Ajouter un livre',
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
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return [
                    'Mathematics / Mathématiques',
                    'Physics / Physique',
                    'Science / Science',
                    'Chemistry / Chimie',
                    'French (language)',
                    'English (language)',
                    'اللغة العربية / Arabic',
                    'التربية الوطنية والتنشئة المدنية',
                    'التاريخ / History',
                    'الجغرافيا / Geography',
                    'الفلسفة / philosophy',
                    'Music / موسيقى',
                    'Religion /دين ',
                    'Other / Autre'
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
                    decoration: InputDecoration(
                      labelText: currentLanguage == 'en'
                          ? 'Select Material'
                          : 'Sélectionner le matériau',
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
                displayStringForOption: (String option) => option,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText:
                      currentLanguage == 'en' ? 'Book Name' : 'Nom du livre',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              GradeInputField(
                  currentLanguage: currentLanguage,
                  gradeController: _gradeController),
              const SizedBox(height: 16.0),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: currentLanguage == 'en'
                      ? 'Your Address'
                      : 'Votre adresse',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: currentLanguage == 'en' ? 'Price USD' : 'Prix USD',
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
                    decoration: InputDecoration(
                      labelText: currentLanguage == 'en'
                          ? 'Select School Name'
                          : 'Sélectionnez le nom de l’école',
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
                displayStringForOption: (String option) => option,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedcondition,
                hint: Text(currentLanguage == 'en'
                    ? 'Select Book Condition'
                    : 'Sélectionnez l’état du livre'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedcondition = newValue;
                  });
                },
                items: [
                  currentLanguage == 'en' ? 'Excellent' : 'Excellente',
                  currentLanguage == 'en' ? 'Good' : 'Bien',
                  currentLanguage == 'en' ? 'Bad' : 'Mauvais'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _publisherController,
                decoration: InputDecoration(
                  labelText: currentLanguage == 'en' ? 'Publisher' : 'Edition',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: currentLanguage == 'en'
                      ? 'Year of Publication'
                      : 'Année de publication',
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                    currentLanguage == 'en' ? 'Add Book' : 'Ajouter un livre',
                    style: const TextStyle(color: Colors.white)),
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
