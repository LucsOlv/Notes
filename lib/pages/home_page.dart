import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes/models/note_data.dart';

import 'package:provider/provider.dart';

import '../models/note.dart';
import 'editingnote_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initialiedNotes();
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');
    goToNotePage(newNote, true);
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).removeNote(note);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditingNotePage(note: note, isNewNote: isNewNote),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          onPressed: createNewNote,
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
        backgroundColor: CupertinoColors.systemBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                  child: Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              value.getAllNotes().isEmpty
                  ? const Center(
                      child: Text(
                      "Nothing here. . .",
                      style: TextStyle(fontSize: 18),
                    ))
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                        value.getAllNotes().length,
                        (index) => CupertinoListTile(
                          title: Text(
                            value.getAllNotes()[index].text,
                          ),
                          onTap: () =>
                              goToNotePage(value.getAllNotes()[index], false),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteNote(value.getAllNotes()[index]);
                            },
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
