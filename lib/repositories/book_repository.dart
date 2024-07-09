import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sbi_flutter_firebase/models/book_model.dart';

class BookRepository {
  // TODO: update databaseURL
  // static final firebaseApp = Firebase.app();
  // static final rtdb = FirebaseDatabase.instanceFor(
  //   app: firebaseApp,
  //   databaseURL: 'https://sbi-flutter-firebase-6f577-default-rtdb.firebaseio.com/',
  // );
  // final DatabaseReference ref = rtdb.ref();

  // Future<Either<List<BookModel>, String>> getBooks() async {
  //   try {
  //     final snapshot = await ref.child('books').get();
  //     List<BookModel> list = [];
  //     if (snapshot.exists) {
  //       final temp = (snapshot.value as Map).values.toList();
  //       list = List<BookModel>.from(temp.map((data) => BookModel.fromJson(Map<String, dynamic>.from(data))));
  //     }
  //     return Left(list);
  //   } catch (e) {
  //     return const Right("Something went wrong");
  //   }
  // }

  // Future<bool> storeBook(BookModel book) async {
  //   try {
  //     if (book.id == null) return false;
  //     await ref.child('books').update({book.id!: book.toJson()});
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> updateBook(BookModel book) async {
  //   try {
  //     if (book.id == null) return false;
  //     await ref.child('books').update({book.id!: book.toJson()});
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> deleteBook(String id) async {
  //   try {
  //     await ref.child('books/$id').remove();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
