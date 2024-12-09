import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  static void navigate(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ChatScreen();
        },
      ),
    );
  }
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Henna"),
          leading: ClipOval(
            child: Image.network(
              'https://funkylife.in/wp-content/uploads/2023/08/whatsapp-dp-717-1020x1024.jpg',
              width: 48,
              height: 48,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return Card(
                    color: Colors.pink.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'you\'re making multiple requests to the same server',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm a')
                                .format(DateTime.now()),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'you\'re making multiple requests to the same server',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy hh:mm a')
                              .format(DateTime.now()),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                suffixIcon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
