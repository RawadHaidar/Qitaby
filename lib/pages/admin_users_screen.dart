import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qitaby_web/customized_widgets/pages_appbar.dart';

class AdminUserPage extends StatefulWidget {
  @override
  _AdminUserPageState createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _users = [];
  String? _selectedFilter;
  String? _filterValue;
  int _filteredCount = 0;

  // Filter Options
  final List<String> filterOptions = [
    'username',
    'email',
    'address',
    'phone_number',
    'rating',
    'type'
  ];

  @override
  void initState() {
    super.initState();
    _getUsers(); // Initially load all users
  }

  // Fetch users based on selected filter
  void _getUsers() async {
    Query query = _firestore.collection('users');

    // If a filter is applied, update the query
    if (_selectedFilter != null &&
        _filterValue != null &&
        _filterValue!.isNotEmpty) {
      query = query.where(_selectedFilter!, isEqualTo: _filterValue);
    }

    QuerySnapshot snapshot = await query.get();
    setState(() {
      _users = snapshot.docs;
      _filteredCount = _users.length; // Count the filtered users
    });
  }

  // Function to delete a user from Firestore
  void _deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User deleted")));
      _getUsers(); // Refresh the list after deletion
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to delete user")));
    }
  }

  // UI for the admin page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppbar(theme: AppBarThemeType.light),
      // appBar: AppBar(
      //   title: Text('Admin: Manage Users'),
      // ),
      body: Column(
        children: [
          const Text(
            'Admin: Manage Users',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Filter section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        hint: Text('Select Filter'),
                        value: _selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                        },
                        items: filterOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Filter Value',
                        ),
                        onChanged: (value) {
                          _filterValue = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _getUsers,
                  child: Text('Apply Filter'),
                ),
              ],
            ),
          ),

          // Display the filtered count
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Filtered Users: $_filteredCount'),
          ),

          // List of users as cards
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                var user = _users[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteConfirmationDialog(user.id),
                    ),
                    title: Text(user['username']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${user['email']}'),
                        Text('Phone: ${user['phone_number']}'),
                        Text('Type: ${user['type']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog before deleting a user
  void _showDeleteConfirmationDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete User"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteUser(userId); // Delete user
              },
            ),
          ],
        );
      },
    );
  }
}
