import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';

class AdminBookPage extends StatefulWidget {
  @override
  _AdminBookPageState createState() => _AdminBookPageState();
}

class _AdminBookPageState extends State<AdminBookPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _books = [];
  String? _selectedFilter;
  String? _filterValue;
  int _filteredCount = 0;

  // Filter Options
  final List<String> filterOptions = [
    'name',
    'publisher',
    'schoolName',
    'condition',
    'username',
    'usertype',
    'yearOfPublication'
  ];

  @override
  void initState() {
    super.initState();
    _getBooks(); // Initially load all books
  }

  // Fetch books based on selected filter
  void _getBooks() async {
    Query query = _firestore.collection('books');

    // Check if a filter is selected and a value is provided
    if (_selectedFilter != null &&
        _filterValue != null &&
        _filterValue!.isNotEmpty) {
      // Special case for yearOfPublication, which is stored as a number
      if (_selectedFilter == 'yearOfPublication') {
        int? year;
        try {
          year = int.parse(_filterValue!);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Invalid year format. Please enter a valid number.')),
          );
          return; // Exit if the input is invalid
        }
        query = query.where(_selectedFilter!, isEqualTo: year);
      } else {
        // For other filters, continue with string comparison
        query = query.where(_selectedFilter!, isEqualTo: _filterValue);
      }
    }

    QuerySnapshot snapshot = await query.get();
    setState(() {
      _books = snapshot.docs;
      _filteredCount = _books.length; // Update the filtered count
    });
  }

  // Function to delete a book from Firestore
  void _deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Book deleted")));
      _getBooks(); // Refresh the list after deletion
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to delete book")));
    }
  }

  // Function to edit a book (Navigate to an edit screen)
  void _editBook(String bookId) {
    // Navigation to the book edit screen with the bookId
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookEditScreen(bookId: bookId),
      ),
    );
  }

  // UI for the admin book page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      body: Column(
        children: [
          const Text(
            'Admin: Manage Books',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Filter section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Filter'),
                    value: _selectedFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFilter = newValue;
                      });
                    },
                    items: filterOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Filter Value',
                    ),
                    onChanged: (value) {
                      _filterValue = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _getBooks,
                  child: Text('Apply Filter'),
                ),
              ],
            ),
          ),

          // Display the filtered count
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Filtered Books: $_filteredCount'),
          ),

          // List of books as cards
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                var book = _books[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteConfirmationDialog(book.id),
                    ),
                    title: Text(book['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Publisher: ${book['publisher']}'),
                        Text('Price: ${book['price']}'),
                        Text('Condition: ${book['condition']}'),
                        Text('School: ${book['schoolName']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editBook(book.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog before deleting a book
  void _showDeleteConfirmationDialog(String bookId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Book"),
          content: Text("Are you sure you want to delete this book?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteBook(bookId); // Delete book
              },
            ),
          ],
        );
      },
    );
  }
}

// Sample BookEditScreen for editing a book's details
class BookEditScreen extends StatelessWidget {
  final String bookId;
  BookEditScreen({required this.bookId});

  @override
  Widget build(BuildContext context) {
    // Here, you would implement the UI for editing the book
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Center(
        child: Text('Edit form for book with ID: $bookId'),
      ),
    );
  }
}
