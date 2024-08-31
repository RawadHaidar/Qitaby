import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/aboutus.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/book_details_screen.dart';
import 'package:qitaby_web/profile_screen.dart';
import 'package:qitaby_web/book_service.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/add_book_screen.dart';

class SearchBookScreen extends StatefulWidget {
  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  String? selectedSchoolName;
  List<String> schoolNames = [];
  String? selectedGrade;
  List<String> schoolGrades = [];
  String? selectedMaterial;

  @override
  void initState() {
    super.initState();
    BookService().fetchSchoolNames().then((names) {
      setState(() {
        schoolNames = names;
      });
    });
    BookService().fetchGrades().then((grades) {
      setState(() {
        schoolGrades = grades;
      });
    });
  }

  Future<void> _searchBooks(
      String schoolquery, String materialquery, String gradequery) async {
    final books = await Provider.of<BookService>(context, listen: false)
        .searchBooks(schoolquery, materialquery, gradequery);
    setState(() {
      _books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor:
            Colors.green[800], // Match the style of the provided HTML
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
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
                const Text(
                  'Book Shop',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
                      Map<String, dynamic>? userData = snapshot.data;
                      if (userData != null) {
                        String username =
                            userData['username'] ?? 'No username found';
                        return Center(
                            child: Text(
                          'user:\n$username',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ));
                      } else {
                        return const Center(child: Text('No username found'));
                      }
                    } else {
                      return const Center(child: Text('Something went wrong'));
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
                    const Text('Profile',
                        style: TextStyle(color: Colors.white)),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.person, color: Colors.white),
                      iconSize: 25.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () async {
                        await Provider.of<AuthService>(context, listen: false)
                            .signOut();
                        Navigator.pop(context);
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
          const SizedBox(
            height: 50,
          ),
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
                'All',
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
                if (selection == 'All') {
                  selectedMaterial = null;
                }
              });
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search by book type',
          //       suffixIcon: IconButton(
          //         icon: const Icon(Icons.search),
          //         onPressed: () {
          //           _searchBooks(_searchController.text,
          //               selectedSchoolName ?? '', selectedGrade ?? '');
          //         },
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12.0),
          //         borderSide: BorderSide(color: Colors.green[800]!),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  selectedSchoolName = null;
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
                  ),
                );
              },
              displayStringForOption: (String option) => option,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedGrade,
              hint: const Text('Select Grade'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGrade = newValue;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('None'), // Display text for null value
                ),
                ...List.generate(12, (index) {
                  String grade = (index + 1).toString();
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(grade),
                  );
                })
              ],
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchBooks(selectedMaterial ?? '', selectedSchoolName ?? '',
                  selectedGrade ?? '');
            },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(book: book),
                        ),
                      );
                    },
                    child: ListTile(
                      tileColor: Colors.green[50], // Match the theme
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          book.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.green[900], // Match the theme
                          ),
                        ),
                      ),
                      subtitle: Text(book.schoolName),
                      trailing: Text(
                        '\$${book.price.toString()}',
                        style: TextStyle(
                          color: Colors.green[800], // Match the theme
                        ),
                      ),
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
          backgroundColor: Colors.green[800], // Match the theme
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookScreen()),
            );
          },
          child: const Text(
            'Sell a book!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.green[50], // Light background color
    );
  }
}
