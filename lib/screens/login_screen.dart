import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chat/constants/app_images.dart';
import 'package:my_chat/extensions/show_snackbar_ext.dart';
import 'package:my_chat/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : OutlinedButton.icon(
                      onPressed: () => _onGoogleSigninPressed(context),
                      icon: Image.asset(
                        AppImages.googlePng,
                        width: 28,
                        height: 28,
                      ),
                      label: const Text('Sign in with Google'),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isLoading = false;

  void _onGoogleSigninPressed(BuildContext context) async {
    if (_isLoading) return;
    try {
      setState(() {
        _isLoading = true;
      });
      final googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw Exception();
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!snapshot.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'uid': userCredential.user!.uid,
            'displayName': userCredential.user!.displayName,
            'photoURL': userCredential.user!.photoURL,
            'email': userCredential.user!.email,
          },
        );
      }

      HomeScreen.navigate(context, userCredential.user!);
    } on FirebaseException catch (e) {
      print("Error: $e");
      context.showSnackbar(
        title: "Oops",
        message: e.message ?? "Unexpected error occurred!",
        contentType: ContentType.failure,
      );
    } catch (e) {
      print("Error: $e");
      context.showSnackbar(
        title: "Oops",
        message: "Unexpected error occurred!",
        contentType: ContentType.failure,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
