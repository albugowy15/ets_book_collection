import 'package:ets_book_collection/db/book_database.dart';
import 'package:ets_book_collection/model/book.dart';
import 'package:ets_book_collection/pages/add_edit_book_page.dart';
import 'package:ets_book_collection/pages/book_detail_page.dart';
import 'package:ets_book_collection/widget/book_card_widget.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late List<Book> books;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refershBooks();
  }

  @override
  void dispose() {
    BooksDatabase.instance.close();
    super.dispose();
  }

  Future refershBooks() async {
    setState(() {
      isLoading = true;
    });
    books = await BooksDatabase.instance.readAllBooks();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : books.isEmpty
                ? const Text(
                    "No Notes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  )
                : buildBooks(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const AddEditBookPage();
          }));

          refershBooks();
        },
      ),
    );
  }

  Widget buildBooks() {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        final book = books[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BookDetailPage(bookId: book.id!),
            ));
            refershBooks();
          },
          child: BookCardWidget(book: book, index: index),
        );
      },
      itemCount: books.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
