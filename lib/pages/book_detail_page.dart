import 'package:ets_book_collection/db/book_database.dart';
import 'package:ets_book_collection/model/book.dart';
import 'package:ets_book_collection/pages/add_edit_book_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;
  const BookDetailPage({super.key, required this.bookId});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshBooks();
  }

  Future refreshBooks() async {
    setState(() => isLoading = true);
    book = await BooksDatabase.instance.readBook(widget.bookId);
    print(book.coverUrl);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [editButton(), deleteButton()]),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    DateFormat.yMMMd().format(book.createdTime),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    book.description,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: book.coverUrl,
                  ),
                ],
              )),
    );
  }

  Widget editButton() => IconButton(
        onPressed: () async {
          if (isLoading) return;
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditBookPage(book: book),
          ));
          refreshBooks();
        },
        icon: const Icon(Icons.edit_outlined),
      );

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await BooksDatabase.instance.delete(widget.bookId);
          Navigator.of(context).pop();
        },
      );
}
