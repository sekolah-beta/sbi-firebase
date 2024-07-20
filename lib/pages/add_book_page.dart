import 'package:flutter/material.dart';
import 'package:sbi_flutter_firebase/models/book_model.dart';
import 'package:sbi_flutter_firebase/repositories/book_repository.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:uuid/uuid.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final BookRepository bookRepository = BookRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final Uuid uuid = const Uuid();

  String? validator(String? value) =>
      value == '' ? 'Input cannot be empty' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Book'),
      ),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: validator,
                decoration: const InputDecoration(
                    label: Text('Title'), hintText: 'Enter Book Title Here...'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: authorController,
                validator: validator,
                decoration: const InputDecoration(
                    label: Text('Author'),
                    hintText: 'Enter Author Name Here...'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            postBooks();
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }

  Future<void> postBooks() async {
    if (!form.currentState!.validate()) return;

    OverlayLoadingProgress.start(context);
    final id = uuid.v4();
    BookModel book = BookModel(
      id: id,
      title: titleController.text,
      author: authorController.text,
    );

    final isSuccess = await bookRepository.storeBook(book);
    OverlayLoadingProgress.stop();
    if (mounted) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Create ${book.title} successfully!'),
        ));
        Navigator.pop(context, book);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Create ${book.title} failed!'),
        ));
      }
    }
  }
}
