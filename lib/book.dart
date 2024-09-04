class Book {
  String id;
  String name;
  String schoolName;
  String grade;
  String userAddress;
  double? price;
  String condition;
  String username;
  String usernumber;
  String material;
  String publisher; // New field
  int yearOfPublication; // New field

  Book({
    required this.id,
    required this.name,
    required this.schoolName,
    required this.grade,
    required this.userAddress,
    this.price,
    required this.condition,
    required this.username,
    required this.usernumber,
    required this.material,
    required this.publisher, // New argument in constructor
    required this.yearOfPublication, // New argument in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toLowerCase(),
      'schoolName': schoolName.toLowerCase(),
      'grade': grade,
      'userAddress': userAddress,
      'price': price,
      'condition': condition.toLowerCase(),
      'username': username,
      'usernumber': usernumber,
      'material': material,
      'publisher': publisher, // Adding new field to the map
      'yearOfPublication': yearOfPublication, // Adding new field to the map
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String? ?? 'Unknown ID',
      name: map['name'] as String? ?? 'Unknown Name',
      schoolName: map['schoolName'] as String? ?? 'Unknown School',
      grade: map['grade'] as String? ?? 'Unknown Grade',
      userAddress: map['userAddress'] as String? ?? 'Unknown Address',
      price: (map['price'] as num?)?.toDouble(),
      condition: map['condition'] as String? ?? 'Unknown condition',
      username: map['username'] as String? ?? 'Unknown Username',
      usernumber: map['usernumber'] as String? ?? 'Unknown Usernumber',
      material: map['material'] as String? ?? 'Unknown Material',
      publisher: map['publisher'] as String? ??
          'Unknown Publisher', // Handle new field
      yearOfPublication:
          map['yearOfPublication'] as int? ?? 0, // Handle new field
    );
  }
}
