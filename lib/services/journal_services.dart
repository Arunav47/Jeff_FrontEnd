import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mental_health_support_chatbot/models/journal_model.dart';

class JournalService {

  static String _baseUrl = "/notes"; // base Url to be added

  static Future<void> addJournal(Journal journal) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: journal.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  
  static Future<void> deleteJournal(Journal journal) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: journal.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Journal>> fetchJournal(String userId) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: { "userId": userId });
    var decoded = jsonDecode(response.body);
    
    List<Journal> journals = [];
    for(var journalsMap in decoded) {
      Journal newJournal = Journal.fromMap(journalsMap);
      journals.add(newJournal);
    }

    return journals;
  }

}