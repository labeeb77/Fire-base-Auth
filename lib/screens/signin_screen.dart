import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_sample/screens/home_screen.dart';
import 'package:firebase_auth_sample/screens/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:overlay_support/overlay_support.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

final TextEditingController emailTextController = TextEditingController();
final TextEditingController passwordTextController = TextEditingController();
ConnectivityResult? _connectivityResult;

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF9600FF), Color(0xFFAEBAF8)]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                signUpLotti("images/105639-signup.json"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "email", Icons.email, false, emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "password", Icons.lock, true, passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signUpButton(context, true, () async {
                  if (_connectivityResult == ConnectivityResult.none) {
                    toast("Please check your internet");
                    return;
                  } else {
                      await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailTextController.text,
                          password: passwordTextController.text)
                      .then((value) {
                    log("login successfully");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
                  }).onError((error, stackTrace) {
                    log("error${error.toString()}");
                    showSimpleNotification(Text("email and password not match"),
                        background: Colors.transparent);
                  });
                  }
                
                }),
                signUpOption(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
