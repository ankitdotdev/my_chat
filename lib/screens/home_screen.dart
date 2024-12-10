import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/screens/chat_screen.dart';
import 'package:my_chat/widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
    this.user, {
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        title: UserTile(
          displayName: user.displayName ?? '',
          email: user.email ?? '',
          photoURL: user.photoURL ?? '',
          padding: EdgeInsets.zero,
          textColor: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('email', isNotEqualTo: user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState
              case ConnectionState.none || ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          if (snapshot.hasError || !snapshot.hasData) {
            if (kDebugMode) {
              print("Error: ${snapshot.error.toString()}");
            }
            return Center(
              child: Text(
                  snapshot.error?.toString() ?? 'Unexpected Error occurred!'),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data();
              return UserTile(
                onTap: () {
                  ChatScreen.navigate(
                    context,
                    sender: user,
                    receiver: data,
                  );
                },
                displayName: data['displayName'] ?? '',
                email: data['email'] ?? '',
                photoURL: data['photoURL'] ?? '',
              );
            },
          );
        },
      ),
    );
  }

  static void navigate(BuildContext context, User user) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user),
      ),
      (route) {
        return false;
      },
    );
  }
}
