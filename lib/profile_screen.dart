import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/book_details_screen.dart';
import 'package:qitaby_web/book_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Book> _books = [];
  String? phoneNumber;

  Future<void> _searchBooks(String phoneNumberQuery) async {
    final books = await Provider.of<BookService>(context, listen: false)
        .searchUserBooks(phoneNumberQuery);
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<AuthService>(
        builder: (context, authService, child) {
          return FutureBuilder<Map<String, dynamic>?>(
            future: authService.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final userData = snapshot.data!;

                phoneNumber = userData['phone_number'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username: ${userData['username']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Phone Number: ${userData['phone_number']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Address: ${userData['address']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    // Add more user data fields as needed
                    InkWell(
                      child: Row(
                        children: [
                          Text('View my books'),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onTap: () => _searchBooks(phoneNumber.toString()),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: InkWell(
                              onTap: () {
                                // Navigate to the BookDetailsScreen and pass the selected book
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailsScreen(book: book),
                                  ),
                                );
                              },
                              child: ListTile(
                                tileColor: Colors.blue[300],
                                // ... rest of the ListTile code (title, subtitle, trailing)
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No user data found'));
              }
            },
          );
        },
      ),
    );
  }
}
