class Book {
  String id;
  String name;
  String schoolName;
  String grade;
  String userAddress;
  double? price;
  String status;
  String username;
  String usernumber;
  String material; // New field

  Book({
    required this.id,
    required this.name,
    required this.schoolName,
    required this.grade,
    required this.userAddress,
    this.price, // Nullable field
    required this.status,
    required this.username,
    required this.usernumber,
    required this.material, // New argument in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toLowerCase(),
      'schoolName': schoolName.toLowerCase(),
      'grade': grade,
      'userAddress': userAddress,
      'price': price,
      'status': status.toLowerCase(),
      'username': username,
      'usernumber': usernumber,
      'material': material, // Adding new field to the map
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String? ?? 'Unknown ID',
      name: map['name'] as String? ?? 'Unknown Name',
      schoolName: map['schoolName'] as String? ?? 'Unknown School',
      grade: map['grade'] as String? ?? 'Unknown Grade',
      userAddress: map['userAddress'] as String? ?? 'Unknown Address',
      price: (map['price'] as num?)?.toDouble(), // Handle nullable price
      status: map['status'] as String? ?? 'Unknown Status',
      username: map['username'] as String? ?? 'Unknown Username',
      usernumber: map['usernumber'] as String? ?? 'Unknown Usernumber',
      material:
          map['material'] as String? ?? 'Unknown Material', // Handle new field
    );
  }
}
