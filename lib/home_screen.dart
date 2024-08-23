import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/aboutus.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/book_details_screen.dart';
import 'package:qitaby_web/profile_screen.dart';
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
    BookService().fetchSchoolNames().then((names) {
      setState(() {
        schoolNames = names;
        print('State updated with school names: $schoolNames');
      });
    });
    BookService().fetchGrades().then((grades) {
      setState(() {
        schoolGrades = grades;
        print('State updated with school grades: $schoolGrades');
      });
    });
  }

  Future<void> _searchBooks(
      String schoolquery, String bookquery, String gradequery) async {
    final books = await Provider.of<BookService>(context, listen: false)
        .searchBooks(schoolquery, bookquery, gradequery);
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to the AboutUsPage when the logo is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/logo/logo.jpeg',
                    height: 100,
                  ),
                ),
                Text('Book Shop'),
              ],
            ),
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return FutureBuilder<Map<String, dynamic>?>(
                  future: authService.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      Map<String, dynamic>? userData = snapshot.data;
                      if (userData != null) {
                        String username =
                            userData['username'] ?? 'No username found';
                        return Center(child: Text('Welcome, $username!'));
                      } else {
                        return Center(child: Text('No username found'));
                      }
                    } else {
                      return Center(child: Text('Something went wrong'));
                    }
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text('About Us'),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUsPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.info_outline),
                      iconSize: 25.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Profile'),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.person),
                      iconSize: 25.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Logout'),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        await Provider.of<AuthService>(context, listen: false)
                            .signOut();
                      },
                      iconSize: 25.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                        _searchController.text,
                        selectedSchoolName.toString(),
                        selectedGrade.toString());
                    print('Searching for books: ' +
                        _searchController.text +
                        '...' +
                        selectedSchoolName.toString());
                  },
                ),
              ),
            ),
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedGrade,
              hint: Text('Select Grade'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGrade = newValue;
                });
              },
              items: schoolGrades.isNotEmpty
                  ? schoolGrades.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : null,
            ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: book),
                        ),
                      );
                    },
                    child: ListTile(
                      tileColor: Colors.blue[250],
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          book.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      subtitle: Text(book.schoolName),
                      trailing: Text('\$${book.price.toString()}'),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 100.0,
        height: 80.0,
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
