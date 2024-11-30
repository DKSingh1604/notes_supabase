// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text editing controllers
  final textController = TextEditingController();

  //CREATE - a note and save in supabase

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //save button
          TextButton(
            onPressed: () {
              saveNote();
              Navigator.pop(context);
              textController.clear();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  //saving note
  void saveNote() async {
    await Supabase.instance.client
        .from('notes')
        .insert({'body': textController.text});
  }

  //READ - notes from supabase in app

  final _notesStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          //loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //loaded
          final notes = snapshot.data!;

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                //get inividual note
                final note = notes[index];

                //get the column you want
                final noteText = note['body'];

                //return to the UI
                return ListTile(
                  title: Text(noteText),
                );
              });
        },
      ),
    );
  }
}
