import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/note.dart';

class HiveDatabase {
  final _myBox = Hive.box("note_database");

  List<Note> loadNotes() {
    List<Note> saveNotesFormatteed = [];

    if (_myBox.get("ALLNOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALLNOTES");

      for (var i = 0; i < savedNotes.length; i++) {
        Note individual = Note(
          id: savedNotes[i][0],
          text: savedNotes[i][1],
        );
        saveNotesFormatteed.add(individual);
      }
    } else {
      saveNotesFormatteed.add(Note(
        id: 0,
        text: "First Note...",
      ));
    }
    return saveNotesFormatteed;
  }

  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    _myBox.put("ALLNOTES", allNotesFormatted);
  }
}
