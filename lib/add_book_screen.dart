import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book.dart';
import 'book_service.dart';

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

  @override
  void initState() {
    super.initState();
    BookService().fetchSchoolNames().then((names) {
      setState(() {
        schoolNames = names;
        print('State updated with school names: $schoolNames');
      });
    });
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
      userAddress: _addressController.text,
      price: double.parse(_priceController.text),
      status: selectedStatus!,
    );

    try {
      await Provider.of<BookService>(context, listen: false).addBook(book);
      print('Book added successfully');
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
            DropdownButton<String>(
              value: selectedSchoolName,
              hint: Text('Select School Name'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSchoolName = newValue;
                  errorMessage =
                      null; // Clear error message when selection is made
                });
              },
              items: schoolNames.isNotEmpty
                  ? schoolNames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : null, // Show an empty dropdown when no items are available
            ),
            DropdownButton<String>(
              value: selectedStatus,
              hint: Text('Select Status'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue;
                  errorMessage =
                      null; // Clear error message when selection is made
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
              child: Text('Add Book'),
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
