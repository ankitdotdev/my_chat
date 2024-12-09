import 'package:flutter/material.dart';
import 'package:my_chat/screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void navigate(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
      (route) {
        return false;
      },
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chat'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: _onUserTileTap,
            title: const Text("Henna"),
            subtitle: const Text("24 messages"),
            leading: ClipOval(
              child: Image.network(
                'https://funkylife.in/wp-content/uploads/2023/08/whatsapp-dp-717-1020x1024.jpg',
                width: 48,
                height: 48,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onUserTileTap() {
    ChatScreen.navigate(context);
  }
}
