import 'package:ets_book_collection/model/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookCardWidget extends StatelessWidget {
  final Book book;
  final int index;

  const BookCardWidget({super.key, required this.book, required this.index});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(book.createdTime);
    return Card(
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time),
              const SizedBox(
                height: 4,
              ),
              Text(
                book.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                book.description,
              ),
            ],
          )),
    );
  }
}
