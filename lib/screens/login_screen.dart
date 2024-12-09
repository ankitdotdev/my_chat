import 'package:flutter/material.dart';
import 'package:my_chat/constants/app_images.dart';
import 'package:my_chat/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              AppImages.elustrator1Jpg,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _onGoogleSigninPressed(context),
                  icon: Image.asset(
                    AppImages.googlePng,
                    width: 28,
                    height: 28,
                  ),
                  label: const Text('Sign in with Google'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onGoogleSigninPressed(BuildContext context) {
    HomeScreen.navigate(context);
  }
}
