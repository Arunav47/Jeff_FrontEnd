import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/pages/chatbot/chatbot_chat.dart';

class MoodAssessMent extends StatefulWidget {
  const MoodAssessMent({super.key});

  @override
  State<MoodAssessMent> createState() => _MoodAssessMentState();
}

class _MoodAssessMentState extends State<MoodAssessMent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mood Assessment"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "How are you feeling today?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "happy",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.green),
                    child: const Text("Happy"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "calm",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor:
                            const Color.fromARGB(255, 62, 216, 67)),
                    child: const Text("Calm"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "excitement",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor:
                            const Color.fromARGB(255, 150, 210, 82)),
                    child: const Text("Excitement"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "boredom",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.amber),
                    child: const Text("Boredom"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "anxiety",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.brown),
                    child: const Text("Anxiety"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "sadness",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.blue),
                    child: const Text("Sadness"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "fear",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.blueGrey),
                    child: const Text("Fear"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage(
                                    mood: "anger",
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

                        minimumSize: const Size(120, 50),
                        backgroundColor: Colors.red),
                    child: const Text("Anger"),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
