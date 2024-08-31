import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Services Cards Section
          Wrap(
            spacing: 40.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.center,
            children: [
              ServiceCard(
                imageUrl:
                    'https://cdn.durable.co/shutterstock/2SbZMUrOKzqmZsVVUZs8PkjmOThhagnv87bG1AmuADjSS7zM8ohyb5PaL3KepGcX.jpeg',
                title: 'Book Price Updates',
                description:
                    'Regularly updated live time prices of used school books.',
              ),
              ServiceCard(
                imageUrl:
                    'https://cdn.durable.co/shutterstock/38g3neUOghn3d3owxehS9abr06Aq37H9pHSo6ONQmo6sE2cdL8cKC9qWkR2y44LH.jpeg',
                title: 'Affordable Options',
                description:
                    'Access to affordable used school books for those unable to afford new book prices.',
              ),
              ServiceCard(
                imageUrl:
                    'https://cdn.durable.co/shutterstock/64mBoGsIbyOtxkJQbRNSJq5uBXkIXOn9GLnrXc35n6PxS0uAWxZZtwhnX3e2Iaca.jpeg',
                title: 'Online Payment',
                description:
                    'Secure and convenient online payment options for book purchases.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  ServiceCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
