import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.displayName,
    required this.email,
    required this.photoURL,
    this.onTap,
    this.padding,
    this.textColor,
  });

  final String displayName;
  final String email;
  final String photoURL;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: padding,
      title: Text(displayName),
      textColor: textColor,
      subtitle: Text(email),
      leading: ClipOval(
        child: Image.network(
          photoURL,
          width: 38,
          height: 38,
        ),
      ),
    );
  }
}
