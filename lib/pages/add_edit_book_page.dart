import 'package:ets_book_collection/db/book_database.dart';
import 'package:ets_book_collection/model/book.dart';
import 'package:ets_book_collection/widget/book_form_widget.dart';
import 'package:flutter/material.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;

  const AddEditBookPage({super.key, this.book});

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String coverUrl;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.book?.title ?? '';
    coverUrl = widget.book?.coverUrl ?? '';
    description = widget.book?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: BookFormWidget(
          title: title,
          description: description,
          coverUrl: coverUrl,
          onChangedTitle: (title) {
            return setState(() {
              this.title = title;
            });
          },
          onChangedDescription: (description) {
            return setState(() {
              this.description = description;
            });
          },
          onChangedCoverUrl: (coverUrl) {
            return setState(() {
              this.coverUrl = coverUrl;
            });
          },
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid =
        title.isNotEmpty && coverUrl.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? Colors.blueGrey : Colors.grey.shade700,
        ),
        onPressed: addOrUpdate,
        child: const Text("Save"),
      ),
    );
  }

  void addOrUpdate() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.book != null;
      if (isUpdating) {
        await updateBook();
      } else {
        addBook();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateBook() async {
    final book = widget.book!.copy(
      title: title,
      coverUrl: coverUrl,
      description: description,
    );
    await BooksDatabase.instance.update(book);
  }

  Future addBook() async {
    final book = Book(
      title: title,
      coverUrl: coverUrl,
      description: description,
      createdTime: DateTime.now(),
    );

    await BooksDatabase.instance.create(book);
  }
}
