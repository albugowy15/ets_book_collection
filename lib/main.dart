import 'dart:io';
import 'package:ets_book_collection/pages/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lehttp_overrides/lehttp_overrides.dart';

void main() async {
  if (Platform.isAndroid) {
    HttpOverrides.global = LEHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static String title = 'Book Collection';
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: const BookPage(),
    );
  }
}
