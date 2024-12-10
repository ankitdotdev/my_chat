import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile({
    super.key,
    required this.message,
    this.sendedAt,
    this.isSender = true,
  });

  final String message;
  final DateTime? sendedAt;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSender ? Colors.pink.shade100 : Colors.grey,
      margin: EdgeInsets.only(
        bottom: 4,
        top: 4,
        right: isSender ? 50 : 4,
        left: isSender ? 4 : 50,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                sendedAt != null
                    ? DateFormat('dd/MM/yyyy hh:mm a').format(sendedAt!)
                    : '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
