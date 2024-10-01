import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_support_chatbot/models/journal_model.dart';
import '../services/journal_services.dart';

class JournalProvider with ChangeNotifier {

  bool isLoading = true;
  List<Journal> journals = [];

  
  JournalProvider() {
    fetchJournal();
  }


  void sortNotes() {
    journals.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  List<Journal> filter(String filterQuery) {
    return journals.where((element) => element.title!.toLowerCase().
    contains(filterQuery.toLowerCase()) || element.content!.toLowerCase().contains(filterQuery.toLowerCase())).toList();
  }

  void addJournal(Journal note) {
    journals.add(note);
    sortNotes();
    notifyListeners();
    JournalService.addJournal(note);
  }

  void updateJournal(Journal note) {
    int indexOfNote = journals.indexOf(journals.firstWhere((element) => element.id == note.id));
    journals[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    JournalService.addJournal(note);
  }

  void deleteJournal(Journal note) {
    int indexOfNote = journals.indexOf(journals.firstWhere((element) => element.id == note.id));
    journals.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    JournalService.deleteJournal(note);
  }

  void fetchJournal() async {
    journals = await JournalService.fetchJournal(FirebaseAuth.instance.currentUser!.uid);
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

}