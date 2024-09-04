import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';
import 'package:qitaby_web/language_provider.dart';
import 'package:qitaby_web/pages/aboutus.dart';
import 'package:qitaby_web/auth_service.dart';
import 'package:qitaby_web/pages/book_details_screen.dart';
import 'package:qitaby_web/pages/profile_screen.dart';
import 'package:qitaby_web/book_service.dart';
import 'package:qitaby_web/book.dart';
import 'package:qitaby_web/pages/add_book_screen.dart';

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
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.dark),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            currentLanguage == 'en' ? 'Search books' : 'Rechercher des livres',
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
                currentLanguage == 'en' ? 'Mathematics' : 'Mathématiques',
                currentLanguage == 'en' ? 'Physics' : 'Physique',
                currentLanguage == 'en' ? 'Science' : 'Science',
                currentLanguage == 'en' ? 'Chemistry' : 'Chimie',
                'French (language)',
                'English (language)',
                'اللغة العربية',
                'التربية الوطنية والتنشئة المدنية',
                'التاريخ',
                'الجغرافيا',
                'الفلسفة',
                currentLanguage == 'en' ? 'Other' : 'Autre',
                currentLanguage == 'en' ? 'All' : 'Tout',
              ].where((String option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              setState(() {
                selectedMaterial = selection;
                if (selection == 'All' || selection == 'Tout') {
                  selectedMaterial = null;
                }
              });
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
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
                  decoration: InputDecoration(
                    labelText: currentLanguage == 'en'
                        ? 'Select School Name'
                        : "Sélectionnez le nom de l'école",
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
              hint: Text(currentLanguage == 'en'
                  ? 'Select Grade'
                  : 'Sélectionnez le niveau'),
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
                        '${book.price.toString()} USD',
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
          backgroundColor: Color.fromRGBO(18, 41, 27, 1.0), // Match the theme
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBookScreen()),
            );
          },
          child: Text(
            currentLanguage == 'en' ? 'Sell a book!' : 'Vendez un livre!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.green[50], // Light background color
    );
  }
}
