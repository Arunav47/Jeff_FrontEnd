import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/models/journal_model.dart';
import 'package:mental_health_support_chatbot/pages/journal/journal.dart';
import 'package:mental_health_support_chatbot/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalDetails extends StatefulWidget {
  const JournalDetails({super.key});

  @override
  State<JournalDetails> createState() => _JournalDetailsState();
}

class _JournalDetailsState extends State<JournalDetails> {
  String filteredQuery = "";
  @override
  Widget build(BuildContext context) {
    JournalProvider journalProvider = Provider.of<JournalProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Journal History"),
          centerTitle: true,
        ),
        body: (journalProvider.isLoading == false) ? SafeArea(
          child: (journalProvider.journals.length > 0) ? ListView(
            children: [
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      filteredQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search"
                  ),
                ),
              ),
      
              (journalProvider.filter(filteredQuery).length > 0) ? GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemCount: journalProvider.filter(filteredQuery).length,
                itemBuilder: (context, index) {
      
                  Journal currentJournal = journalProvider.filter(filteredQuery)[index];
      
                  return GestureDetector(
                    onTap: () {
                      // Update
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=> JournalPage(isUpdate: true, journal: currentJournal)),
                        
                      );
                    },
                    onLongPress: () {
                      // Delete
                      journalProvider.deleteJournal(currentJournal);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentJournal.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), maxLines: 1, overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 7,),
                          Text(currentJournal.content!, style: TextStyle( fontSize: 18, color: Colors.grey[700] ), maxLines: 5, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  );
      
                },
              ) : Padding(
                padding: EdgeInsets.all(20),
                child: Text("No journal found!", textAlign: TextAlign.center,),
              ),
            ],
          ) : Center(
            child: Text("No journal yet"),
          ),
        ) : Center(
          child: CircularProgressIndicator(),
        ),      
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const JournalPage(isUpdate: false,)
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}