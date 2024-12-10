import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/extensions/show_snackbar_ext.dart';
import 'package:my_chat/widgets/chat_message_tile.dart';
import 'package:my_chat/widgets/user_tile.dart';
import 'package:gap/gap.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.sender,
    required this.receiver,
  });

  final User sender;
  final Map<String, dynamic> receiver;

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  static void navigate(
    BuildContext context, {
    required User sender,
    required Map<String, dynamic> receiver,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChatScreen(
            sender: sender,
            receiver: receiver,
          );
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
        backgroundColor: Colors.pink.shade300,
        foregroundColor: Colors.white,
        title: UserTile(
          padding: EdgeInsets.zero,
          textColor: Colors.white,
          displayName: widget.receiver['displayName'] ?? '',
          email: widget.receiver['email'] ?? '',
          photoURL: widget.receiver['photoURL'] ?? '',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where(
              Filter.or(
                Filter.and(
                  Filter('sender', isEqualTo: widget.sender.email),
                  Filter('receiver', isEqualTo: widget.receiver['email']),
                ),
                Filter.and(
                  Filter('sender', isEqualTo: widget.receiver['email']),
                  Filter('receiver', isEqualTo: widget.sender.email),
                ),
              ),
            )
            .orderBy('sended_at')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _data = snapshot.data!.docs;
          }
          return Column(
            children: [
              if (snapshot.connectionState
                  case ConnectionState.none || ConnectionState.waiting)
                const LinearProgressIndicator(),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    final data = _data[index].data();
                    if (index % 2 == 0) {
                      return ChatMessageTile(
                        message: data['message'] ?? '',
                        sendedAt: data['sended_at']?.toDate(),
                      );
                    }
                    return ChatMessageTile(
                      message: 'Hello world',
                      sendedAt: DateTime.now(),
                      isSender: false,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.pink.shade300,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        widget.sender.photoURL ?? '',
                        width: 48,
                        height: 48,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: TextField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                        controller: _textController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: 'Hi, Type you message here.',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: 54,
                      height: 64,
                      onPressed: () {
                        if (_textController.text.isEmpty) return;
                        try {
                          FirebaseFirestore.instance
                              .collection('messages')
                              .add({
                            'sender': widget.sender.email,
                            'receiver': widget.receiver['email'],
                            'message': _textController.text,
                            'sended_at': DateTime.now(),
                          });

                          _textController.clear();
                        } on FirebaseException catch (e) {
                          context.showSnackbar(
                            title: 'Oops',
                            message: e.message ?? "Unexpected error occurred!",
                          );
                        } catch (e) {
                          context.showSnackbar(
                            title: 'Oops',
                            message: "Unexpected error occurred!",
                          );
                        }
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final _textController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _data = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
