import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qitaby_web/customized_widgets/manu_page.dart';

enum AppBarThemeType {
  dark,
  light,
}

class PagesAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarThemeType theme;

  PagesAppbar({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = theme == AppBarThemeType.dark;

    return AppBar(
      iconTheme: isDarkTheme
          ? const IconThemeData(color: Colors.white)
          : const IconThemeData(
              color: Color.fromRGBO(18, 41, 27, 1.0),
            ),
      toolbarHeight: MediaQuery.of(context).size.height / 10, // Reduced height
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo/137857-200.png',
              width: 50,
              height: 50,
              color: isDarkTheme
                  ? const Color.fromARGB(255, 216, 236, 226)
                  : const Color.fromRGBO(18, 41, 27, 1.0),
            ),
            const SizedBox(width: 10),
            Text(
              'Qitaby',
              style: GoogleFonts.alata(
                textStyle: TextStyle(
                  color: isDarkTheme
                      ? Colors.white
                      : const Color.fromRGBO(
                          18, 41, 27, 1.0), // Adjust text color based on theme
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkTheme
                  ? Colors.white
                  : const Color.fromRGBO(18, 41, 27, 1.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
          ),
        ),
      ],
      backgroundColor: isDarkTheme
          ? const Color.fromRGBO(18, 41, 27, 1.0)
          : Colors.white, // Background color based on theme
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60.0); // Adjust preferred size if needed
}
