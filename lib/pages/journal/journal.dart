import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/models/journal_model.dart';
import 'package:mental_health_support_chatbot/pages/homepage/homepage.dart';
import 'package:mental_health_support_chatbot/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalPage extends StatefulWidget {
  final bool isUpdate;
  final Journal? journal;
  const JournalPage({
    required this.isUpdate,
    this.journal,
    super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Journal newJournal = Journal(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      userid: FirebaseAuth.instance.currentUser!.uid,
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now()
    );
    Provider.of<JournalProvider>(context, listen: false).addJournal(newJournal);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
  }

  void updateNote() {
    widget.journal!.title = titleController.text;
    widget.journal!.content = contentController.text;
    widget.journal!.dateadded = DateTime.now();
    Provider.of<JournalProvider>(context, listen: false).updateJournal(widget.journal!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if(widget.isUpdate) {
      titleController.text = widget.journal!.title!;
      contentController.text = widget.journal!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                if(widget.isUpdate) {
                  updateNote();
                }
                else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check),
            ),
      
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10
            ),
            child: Column(
              children: [
      
                TextField(
                  controller: titleController,
                  autofocus: (widget.isUpdate == true) ? false : true,
                  onSubmitted: (val) {
                    if(val != "") {
                      noteFocus.requestFocus();
                    }
                  },
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none
                  ),
                ),
      
                Expanded(
                  child: TextField(
                    controller: contentController,
                    focusNode: noteFocus,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: const InputDecoration(
                      hintText: "Note",
                      border: InputBorder.none
                    ),
                  ),
                ),
      
              ],
            ),
          ),
        ),
      ),
    );
    }
}