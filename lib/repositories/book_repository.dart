import 'package:firebase_database/firebase_database.dart';
import 'package:sbi_flutter_firebase/models/book_model.dart';

class BookRepository {
  // final DatabaseReference ref = FirebaseDatabase.instance.ref();

  // Future<List<BookModel>> getBooks() async {
  //   final snapshot = await ref.child('books').get();
  //   if (snapshot.exists) {
  //     final temp = (snapshot.value as Map).values.toList();
  //     return List<BookModel>.from(temp.map((data) => BookModel.fromJson(Map<String, dynamic>.from(data))));
  //   } else {
  //     return [];
  //   }
  // }

  // Future<void> storeBook(BookModel book) async {
  //   if (book.id != null) {
  //     await ref.child('books').update({book.id!: book.toJson()});
  //   }
  // }

  // Future<void> updateBook(BookModel book) async {
  //   if (book.id != null) {
  //     await ref.child('books').update({book.id!: book.toJson()});
  //   }
  // }

  // Future<void> deleteBook(String id) async {
  //   await ref.child('books/$id').remove();
  // }
}
