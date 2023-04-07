import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/models/note_data.dart';
import 'package:notes/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("note_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => const MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
