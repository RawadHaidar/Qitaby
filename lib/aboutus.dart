import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to our school book marketplace!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Your one-stop platform for buying and selling school books in Beirut, Lebanon. '
                'We understand the challenges that students and parents face when it comes to finding '
                'affordable and accessible educational resources. That\'s why we created this platform—to make '
                'the process of obtaining school books easier, more affordable, and more sustainable.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Our mission is to connect students, parents, and educators across Beirut with the books '
                'they need for their academic journey. Whether you\'re looking to buy or sell new or used school books, '
                'our platform offers a convenient and user-friendly experience that ensures everyone has access to the materials they need for success.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'How It Works',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Buy: Browse our extensive collection of school books from various sellers. '
                'Use our search and filter options to find exactly what you need based on book title, school name, or grade level.\n\n'
                '- Sell: Have extra books from last year? Easily list them on our platform for others to buy. '
                'It’s a great way to declutter and help others in the community.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Community-Focused: We\'re rooted in Beirut and focused on serving the local community, making it easier '
                'to find books specific to schools in Lebanon.\n\n'
                '- Sustainability: By buying and selling used books, you\'re contributing to a more sustainable environment '
                'by reducing waste and promoting the reuse of resources.\n\n'
                '- Affordability: Our platform helps you save money by offering a wide range of book prices, including more affordable used options.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Join us in creating a more connected and resourceful educational community in Beirut. '
                'Together, we can ensure that every student has the tools they need to succeed!',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsPage(),
  ));
}
