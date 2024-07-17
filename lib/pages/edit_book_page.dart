import 'package:flutter/material.dart';
import 'package:sbi_flutter_firebase/models/book_model.dart';
import 'package:sbi_flutter_firebase/repositories/book_repository.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class EditBookPage extends StatefulWidget {
  final BookModel book;
  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final BookRepository bookRepository = BookRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? validator(String? value) =>
      value == '' ? 'Input cannot be empty' : null;

  @override
  void initState() {
    titleController.text = widget.book.title ?? '';
    authorController.text = widget.book.author ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Update Book'),
        actions: [
          IconButton(
            onPressed: () {
              removeBooks();
            },
            icon: const Icon(Icons.delete),
          )
        ],
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
            editBooks();
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }

  Future<void> editBooks() async {
    if (!form.currentState!.validate()) return;

    OverlayLoadingProgress.start(context);
    BookModel book = BookModel(
      id: widget.book.id,
      title: titleController.text,
      author: authorController.text,
    );

    final isSuccess = await bookRepository.updateBook(book);
    OverlayLoadingProgress.stop();
    if (mounted) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Update ${book.title} successfully!'),
        ));
        Navigator.pop(context, book);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Update ${book.title} failed!'),
        ));
      }
    }
  }

  Future<void> removeBooks() async {
    OverlayLoadingProgress.start(context);

    final isSuccess = await bookRepository.deleteBook(widget.book.id!);
    OverlayLoadingProgress.stop();
    if (mounted) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Delete ${widget.book.title} successfully!'),
        ));
        Navigator.pop(context, widget.book);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Delete ${widget.book.title} failed!'),
        ));
      }
    }
  }
}
