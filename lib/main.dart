import 'package:flutter/material.dart';
import 'package:notes_supabase/notes_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //supabase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://ecatlvcslvwrqipuwyst.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVjYXRsdmNzbHZ3cnFpcHV3eXN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NTM4NDYsImV4cCI6MjA0ODUyOTg0Nn0.MzBDND_-kMvxNBDwnXHQQNMKErPQAWSbsisryBxI2Bc",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
