import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/firebase_options.dart';
import 'package:my_chat/screens/home_screen.dart';
import 'package:my_chat/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: _isUserLoggedIn(),
    );
  }

  Widget _isUserLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return HomeScreen(user);
    }
    return const LoginScreen();
  }
}
