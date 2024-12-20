import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/language_provider.dart';
import 'package:qitaby_web/pages/book_details_screen.dart';
import 'package:qitaby_web/book_service.dart';
import 'package:qitaby_web/pages/add_book_screen.dart'; // Import your AddBookScreen here

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Book> _books = [];
  String? phoneNumber;
  String? uid;

  void _deleteBook(int index) {
    final bookId = _books[index].id;

    Provider.of<BookService>(context, listen: false)
        .deleteBook(bookId)
        .then((_) {
      setState(() {
        _books.removeAt(index);
      });
    }).catchError((error) {
      // print("Failed to delete book: $error");
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Book book, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Book"),
          content: Text("Are you sure you want to delete '${book.name}'?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                _deleteBook(index);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _searchBooks(String uidquery) async {
    final books = await Provider.of<BookService>(context, listen: false)
        .searchUserBooks(uidquery);
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset(
              'assets/logo/137857-200.png',
              width: 40,
              height: 40,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Qitaby',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF18291B), // Dark green background
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return FutureBuilder<Map<String, dynamic>?>(
                  future: authService.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!;

                      // phoneNumber = userData['phone_number'];
                      uid = userData['uid'];

                      return Expanded(
                        // Wrap all content that should expand
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              currentLanguage == 'en' ? 'Profile' : 'Profil',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.alata(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(
                                      18, 41, 27, 1.0), // White text color
                                  fontSize: 25, // Heading large size
                                  fontWeight: FontWeight
                                      .bold, // Bold weight for emphasis
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              currentLanguage == 'en'
                                  ? 'Username: ${userData['username']}'
                                  : 'Nom d’utilisateur: ${userData['username']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              currentLanguage == 'en'
                                  ? 'Phone Number: ${userData['phone_number']}'
                                  : 'Numéro de téléphone: ${userData['phone_number']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              currentLanguage == 'en'
                                  ? 'Address: ${userData['address']}'
                                  : 'Adresse: ${userData['address']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            // Add more user data fields as needed
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddBookScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 20.0),
                                  backgroundColor: Color(
                                      0xFF2A3A27), // Dark green button color
                                ),
                                child: Text(
                                  currentLanguage == 'en'
                                      ? 'Add a Book'
                                      : 'Ajouter un livre',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ElevatedButton(
                                onPressed: () => _searchBooks(uid.toString()),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 20.0),
                                  backgroundColor: Color(
                                      0xFF2A3A27), // Dark green button color
                                ),
                                child: Text(
                                  currentLanguage == 'en'
                                      ? 'View my books'
                                      : 'Voir mes livres',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              // Use Expanded properly to fill remaining space
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
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            book.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(book.schoolName),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${book.price.toString()}USD',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () {
                                                _showDeleteConfirmationDialog(
                                                    context, book, index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No user data found'));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
