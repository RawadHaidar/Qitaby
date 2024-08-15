import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/book_details_screen.dart';
import 'book_service.dart';
import 'book.dart';
import 'add_book_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  String? selectedSchoolName;
  List<String> schoolNames = [];
  String? selectedGrade;
  List<String> schoolGrades = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
    BookService().fetchSchoolNames().then((names) {
      setState(() {
        schoolNames = names;
        print('State updated with school names: $schoolNames'); // Debug print
      });
    });
    BookService().fetchGrades().then((grades) {
      setState(() {
        schoolGrades = grades;
        print('State updated with school grades: $schoolGrades'); // Debug print
      });
    });
  }

  Future<void> _loadBooks() async {
    final books =
        await Provider.of<BookService>(context, listen: false).getBooks();
    setState(() {
      _books = books;
    });
  }

  Future<void> _searchBooks(String schoolquery, String bookquery) async {
    final books = await Provider.of<BookService>(context, listen: false)
        .searchBooks(schoolquery, bookquery);
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by book name, school name, or grade',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(
                        _searchController.text, selectedSchoolName.toString());
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value:
                    selectedSchoolName, // Initial value should be null or match an item in the list
                hint: Text('Select School Name'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSchoolName = newValue;
                    // _searchBooks(selectedSchoolName.toString());
                  });
                },
                items: schoolNames.isNotEmpty
                    ? schoolNames.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : null, // If you prefer to show an empty dropdown when no items are available
              ),
              DropdownButton<String>(
                value:
                    selectedGrade, // Initial value should be null or match an item in the list
                hint: Text('Select Grade'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGrade = newValue;
                    // _searchBooks(selectedSchoolName.toString());
                  });
                },
                items: schoolGrades.isNotEmpty
                    ? schoolGrades
                        .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : null, // If you prefer to show an empty dropdown when no items are available
              ),
            ],
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
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the BookDetailsScreen and pass the selected book
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: book),
                        ),
                      );
                    },
                    child: ListTile(
                      tileColor: Colors.blue[300],
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(book.name),
                          const Text('  '),
                          Text(book.status),
                        ],
                      ),
                      subtitle: Text(book.schoolName),
                      trailing: Text('\$${book.price.toString()}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 100.0, // Set the desired width
        height: 80.0, // Set the desired height
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookScreen()),
            );
          },
          child: const Text('Sell a book!'),
        ),
      ),
    );
  }
}
