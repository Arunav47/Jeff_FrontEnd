import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> messages = [];
  // final TextEditingController _controller = TextEditingController();
  final String apiUrl = "https://778c-104-28-248-200.ngrok-free.app/chat";
  ChatUser chatUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Jeff");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatBot"),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }
  Widget _buildUI() {
      return DashChat(
        currentUser: chatUser, 
        onSend: (ChatMessage chatMessage){
          _sendMessage(chatMessage.text);
        }, 
        messages: messages,
        inputOptions: const InputOptions(
          inputTextStyle: TextStyle(color: Colors.black),
          inputDecoration: InputDecoration(
            hintText: "Type a message",
            hintStyle: TextStyle(color: Colors.grey),
          )
        ),
    );
  }

  Future<void> _sendMessage(String message) async {
    // Add the user's message to the chat
    final userMessage = ChatMessage(
      text: message,
      user: chatUser,
      createdAt: DateTime.now(),
    );
    setState(() {
      messages.insert(0, userMessage);
    });

    try {
      // Prepare the API request
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final chatbotReply = responseBody['reply'] ?? "No reply from the chatbot.";

        // Add the chatbot's response to the chat
        final botMessage = ChatMessage(
          text: chatbotReply,
          user: geminiUser,
          createdAt: DateTime.now(),
        );

        setState(() {
          messages.insert(0, botMessage);
        });
      } else {
        // Handle the error response from the API
        setState(() {
          messages.insert(0, ChatMessage(
            text: "Failed to get a response from Jeff. Please try again later.",
            user: geminiUser,
            createdAt: DateTime.now(),
          ));
        });
      }
    } catch (error) {
      // Handle any other errors (like network issues)
      setState(() {
        messages.insert(0, ChatMessage(
          text: "An error occurred: $error",
          user: geminiUser,
          createdAt: DateTime.now(),
        ));
      });
    }
  }
}