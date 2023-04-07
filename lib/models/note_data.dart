import 'package:flutter/cupertino.dart';
import 'package:notes/data/hive_data.dart';
import 'package:notes/models/note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Note> _allNotes = [
    Note(
      id: 0,
      text: "Notas",
    ),
  ];

  void initialiedNotes() {
    _allNotes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return _allNotes;
  }

  void addNotes(Note note) {
    _allNotes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    _allNotes.remove(note);
    notifyListeners();
  }

  void updateNote(Note note, String text) {
    for (var i = 0; i < _allNotes.length; i++) {
      if (_allNotes[i].id == note.id) {
        _allNotes[i].text = text;
      }
      notifyListeners();
    }
  }
}
