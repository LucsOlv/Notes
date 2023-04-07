import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/models/note_data.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;
  const EditingNotePage({
    super.key,
    required this.note,
    this.isNewNote = false,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    loadExistingNote();
    super.initState();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);

    setState(() {
      _controller = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(
            offset: 0,
          ));
    });
  }

  void addNewNote() {
    int i = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).addNotes(
      Note(
        id: i,
        text: text,
      ),
    );
  }

  void updateNotes() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNotes();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: QuillToolbar.basic(
              controller: _controller,
            ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(25),
                  child: QuillEditor.basic(
                      controller: _controller, readOnly: false)))
        ],
      ),
    );
  }
}
