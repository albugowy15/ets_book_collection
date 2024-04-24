const String tableBooks = 'notes';

class BookFields {
  static final List<String> values = [id, title, coverUrl, description, time];
  static const String id = '_id';
  static const String title = 'title';
  static const String coverUrl = 'coverUrl';
  static const String description = 'description';
  static const String time = 'time';
}

class Book {
  final int? id;
  final String title;
  final String coverUrl;
  final String description;
  final DateTime createdTime;

  const Book({
    this.id,
    required this.title,
    required this.coverUrl,
    required this.description,
    required this.createdTime,
  });

  Book copy({
    int? id,
    String? title,
    String? coverUrl,
    String? description,
    DateTime? createdTime,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        coverUrl: coverUrl ?? this.coverUrl,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Book fromJson(Map<String, Object?> json) => Book(
        id: json[BookFields.id] as int?,
        title: json[BookFields.title] as String,
        coverUrl: json[BookFields.coverUrl] as String,
        description: json[BookFields.description] as String,
        createdTime: DateTime.parse(json[BookFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        BookFields.id: id,
        BookFields.title: title,
        BookFields.coverUrl: coverUrl,
        BookFields.description: description,
        BookFields.time: createdTime.toIso8601String(),
      };
}
