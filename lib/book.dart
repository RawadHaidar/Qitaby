class Book {
  String id;
  String name;
  String schoolName;
  String grade;
  String userAddress;
  double? price;
  String status;

  Book({
    required this.id,
    required this.name,
    required this.schoolName,
    required this.grade,
    required this.userAddress,
    required this.price,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toLowerCase(),
      'schoolName': schoolName.toUpperCase(),
      'grade': grade,
      'userAddress': userAddress,
      'price': price,
      'status': status.toLowerCase(),
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      schoolName: map['schoolName'],
      grade: map['grade'],
      userAddress: map['userAddress'],
      price: map['price'],
      status: map['status'],
    );
  }
}
