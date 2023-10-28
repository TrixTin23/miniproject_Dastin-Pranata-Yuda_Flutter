import 'package:flutter/material.dart';

import '../service/api_service.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final APIService apiService = APIService();
  final List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['content']),
                  subtitle: Text(message['role']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Message',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () async {
                      final message = _controller.text;
                      _controller.clear();

                      final response = await apiService.getAIResponse(message);
                      setState(() {
                        _messages.add({
                          'content': message,
                          'role': 'user',
                        });
                        _messages.add({
                          'content': response,
                          'role': 'system',
                        });
                      });
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () async {
          //     final message = _controller.text;
          //     _controller.clear();

          //     final response = await apiService.getAIResponse(message);
          //     setState(() {
          //       _messages.add({
          //         'content': message,
          //         'role': 'user',
          //       });
          //       _messages.add({
          //         'content': response,
          //         'role': 'system',
          //       });
          //     });
          //   },
          //   child: const Text('Send'),
          // ),
        ],
      ),
    );
  }
}
