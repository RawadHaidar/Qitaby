import 'package:cloud_firestore/cloud_firestore.dart';
import 'book.dart';

class BookService {
  final CollectionReference bookCollection =
      FirebaseFirestore.instance.collection("books");
  final CollectionReference schoolCollection =
      FirebaseFirestore.instance.collection("schools");

  Future<void> addBook(Book book) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('books').doc(book.id);
      await docRef.set(book.toMap());
      // print("Book '${book.name}' added successfully!");
    } on FirebaseException catch (e) {
      // print("Error adding book: ${e.message}");
      // Handle potential errors (e.g., network issues, duplicate IDs)
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      final docRef = bookCollection.doc(bookId);
      await docRef.delete();
      // print("Book with ID '$bookId' deleted successfully!");
    } on FirebaseException catch (e) {
      // print("Error deleting book: ${e.message}");
      // Handle potential errors (e.g., network issues, non-existent document)
    } catch (e) {
      // print("Unexpected error: $e");
    }
  }

  Future<List<Book>> getBooks() async {
    final QuerySnapshot snapshot = await bookCollection.get();
    return snapshot.docs
        .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Book>> searchBooks(
      String? nameQuery, String? schoolQuery, String? gradeQuery) async {
    try {
      // Initialize a base query
      Query query = bookCollection;

      // Apply filters only if queries are non-null
      if (nameQuery != null && nameQuery.isNotEmpty) {
        query = query.where('name', isEqualTo: nameQuery.toLowerCase());
      }

      if (schoolQuery != null && schoolQuery.isNotEmpty) {
        query = query.where('schoolName', isEqualTo: schoolQuery.toLowerCase());
      }

      if (gradeQuery != null && gradeQuery.isNotEmpty) {
        query = query.where('grade', isEqualTo: gradeQuery);
      }

      // Execute the query
      final QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        // print('No books found matching the provided criteria.');
      }

      // Map each document to a Book object and return the list
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      // Handle errors
      // print('Error searching books: $e');
      // print('Stack trace: $stackTrace');
      return [];
    }
  }

  Future<List<Book>> searchUserBooks(String? phoneNumberQuery) async {
    try {
      // Ensure phone number query is not null
      if (phoneNumberQuery == null) {
        throw ArgumentError('phoneNumberQuery must be non-null');
      }

      // Firestore query based on phone number (assuming a field 'ownerPhoneNumber' exists)
      final QuerySnapshot snapshot = await bookCollection
          .where('usernumber', isEqualTo: phoneNumberQuery)
          .get();

      if (snapshot.docs.isEmpty) {
        print('No books found for the provided phone number.');
      }

      // Map each document to a Book object and return the list
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      // Handle errors
      print('Error searching books: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  Future<List<String>> fetchSchoolNames() async {
    try {
      // Fetch all documents in the book collection
      final QuerySnapshot snapshot = await schoolCollection.get();

      // Extract unique school names from the documents
      final List<String> schoolNames = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['name'] as String?;
          })
          .where((name) => name != null) // Remove any null values
          .toSet()
          .cast<String>() // Ensure the set contains only non-null Strings
          .toList();

      print('Fetched school names: $schoolNames'); // Debug print

      return schoolNames;
    } catch (e) {
      print('Error fetching school names: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<String>> fetchGrades() async {
    try {
      // Fetch all documents in the book collection
      final QuerySnapshot snapshot = await bookCollection.get();

      // Extract unique school names from the documents
      final List<String> schoolGrades = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['grade'] as String?;
          })
          .where((grade) => grade != null) // Remove any null values
          .toSet()
          .cast<String>() // Ensure the set contains only non-null Strings
          .toList();

      print('Fetched school grades: $schoolGrades'); // Debug print

      return schoolGrades;
    } catch (e) {
      print('Error fetching school grades: $e');
      return []; // Return an empty list in case of an error
    }
  }
}
