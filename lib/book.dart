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
  String usertype;
  String material;
  String publisher; // New field
  int yearOfPublication; // New field
  String userid;

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
    required this.usertype,
    required this.material,
    required this.publisher, // New argument in constructor
    required this.yearOfPublication, // New argument in constructor
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toLowerCase(),
      'schoolName': schoolName.toLowerCase(),
      'class': grade,
      'userAddress': userAddress,
      'price': price,
      'condition': condition.toLowerCase(),
      'username': username,
      'usernumber': usernumber,
      'usertype': usertype,
      'material': material,
      'publisher': publisher, // Adding new field to the map
      'yearOfPublication': yearOfPublication, // Adding new field to the map
      'uid': userid
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String? ?? 'Unknown ID',
      name: map['name'] as String? ?? 'Unknown Name',
      schoolName: map['schoolName'] as String? ?? 'Unknown School',
      grade: map['class'] as String? ?? 'Unknown Grade',
      userAddress: map['userAddress'] as String? ?? 'Unknown Address',
      price: (map['price'] as num?)?.toDouble(),
      condition: map['condition'] as String? ?? 'Unknown condition',
      username: map['username'] as String? ?? 'Unknown Username',
      usernumber: map['usernumber'] as String? ?? 'Unknown Usernumber',
      usertype: map['usertype'] as String? ?? 'Unknown Usertype',
      material: map['material'] as String? ?? 'Unknown Material',
      publisher: map['publisher'] as String? ??
          'Unknown Publisher', // Handle new field
      yearOfPublication:
          map['yearOfPublication'] as int? ?? 0, // Handle new field
      userid: map['uid'] as String? ?? 'Unknown uid',
    );
  }
}
