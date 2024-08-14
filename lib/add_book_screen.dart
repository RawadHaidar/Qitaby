import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book.dart';
import 'book_service.dart';

class AddBookScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
              controller: _schoolNameController,
              decoration: InputDecoration(labelText: 'School Name'),
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
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            ElevatedButton(
              onPressed: () async {
                final book = Book(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  schoolName: _schoolNameController.text,
                  grade: _gradeController.text,
                  userAddress: _addressController.text,
                  price: double.parse(_priceController.text),
                  status: _statusController.text,
                );

                try {
                  await Provider.of<BookService>(context, listen: false)
                      .addBook(book);
                  print('Book added successfully');
                  // Optionally navigate back or show a success message
                } catch (e) {
                  print('Error adding book: $e');
                  // Optionally show an error message to the user
                }
                // Navigator.pop(context);
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
