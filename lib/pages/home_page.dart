import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbi_flutter_firebase/models/book_model.dart';
import 'package:sbi_flutter_firebase/pages/add_book_page.dart';
import 'package:sbi_flutter_firebase/pages/edit_book_page.dart';
import 'package:sbi_flutter_firebase/pages/login_page.dart';
import 'package:sbi_flutter_firebase/pages/register_page.dart';
import 'package:sbi_flutter_firebase/repositories/book_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookRepository bookRepository = BookRepository();
  List<BookModel> books = [];

  @override
  void initState() {
    fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return LoginPage();
                        }));
                      },
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return RegisterPage();
                          }));
                        },
                        child: Text('Register')),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(snapshot.data?.email ?? ''),
              actions: [
                IconButton(
                  onPressed: () {
                    fetchBooks();
                  },
                  icon: const Icon(Icons.refresh),
                ),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () => fetchBooks(),
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return EditBookPage(
                          book: books[index],
                        );
                      })).then((value) {
                        if (value != null) {
                          fetchBooks();
                        }
                      });
                    },
                    title: Text(books[index].title ?? ''),
                    subtitle: Text(books[index].author ?? ''),
                  ));
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return const AddBookPage();
                })).then((value) {
                  if (value != null) {
                    fetchBooks();
                  }
                });
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Future<void> fetchBooks() async {
    if (mounted) {
      setState(() {
        books = [];
      });
    }

    final response = await bookRepository.getBooks();
    response.fold((value) {
      if (mounted) {
        setState(() {
          books = value;
        });
      }
    }, (value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value),
      ));
    });
  }
}
