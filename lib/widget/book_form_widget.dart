import 'package:flutter/material.dart';

class BookFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? coverUrl;

  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  final ValueChanged<String>? onChangedCoverUrl;

  const BookFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    this.coverUrl = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCoverUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 8),
            buildCoverUrl(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Title *", hintText: "The book title"),
      maxLines: 1,
      initialValue: title,
      validator: (title) =>
          title != null && title.isEmpty ? 'The title cannot be empty' : null,
      onChanged: onChangedTitle,
    );
  }

  Widget buildDescription() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Description *", hintText: "The book description"),
      maxLines: 1,
      initialValue: description,
      validator: (description) => description != null && description.isEmpty
          ? 'The description cannot be empty'
          : null,
      onChanged: onChangedDescription,
    );
  }

  Widget buildCoverUrl() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Cover Image *", hintText: "The book image cover url"),
      maxLines: 1,
      initialValue: coverUrl,
      validator: (coverUrl) => coverUrl != null && coverUrl.isEmpty
          ? 'The cover image cannot be empty'
          : null,
      onChanged: onChangedCoverUrl,
    );
  }
}
