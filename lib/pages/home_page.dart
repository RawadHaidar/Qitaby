import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qitaby_web/customized_widgets/affordablebook_section.dart';
import 'package:qitaby_web/customized_widgets/booklistings_section.dart';
import 'package:qitaby_web/customized_widgets/buy_sell_books.dart';
import 'package:qitaby_web/customized_widgets/contact_us_section.dart';
import 'package:qitaby_web/customized_widgets/footer_section.dart';
import 'package:qitaby_web/pages/manu_page.dart';
import 'package:qitaby_web/customized_widgets/qitaby_introduction_section.dart';
import 'package:qitaby_web/customized_widgets/recycle_book_section.dart';
import 'package:qitaby_web/customized_widgets/services_section.dart';
import 'package:qitaby_web/customized_widgets/testimonial_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: MediaQuery.of(context).size.height / 6,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo/137857-200.png',
                  width: 50,
                  height: 50,
                  color: Color.fromARGB(255, 216, 236, 226),
                ),
                SizedBox(width: 10), // Adjust spacing as needed
                Text(
                  'Qitaby',
                  style: GoogleFonts.alata(
                    textStyle: const TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 36, // Heading large size
                      fontWeight: FontWeight.bold, // Bold weight for emphasis
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
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  // Handle menu button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
              ),
            ),
          ],
          backgroundColor: Color.fromRGBO(18, 41, 27, 1.0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuySellBooksSection(),
                RecycleBooksSection(),
                const QitabyIntroductionSection(),
                ServicesSection(),
                TestimonialSection(),
                AffordableBooksSection(),
                BookListingsSection(),
                ContactUsSection(),
                FooterSection(),
              ],
            ),
          ),
        ));
  }
}
