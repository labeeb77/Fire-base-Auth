import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_sample/screens/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:overlay_support/overlay_support.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final TextEditingController emailTextController = TextEditingController();
final TextEditingController passwordTextController = TextEditingController();
final TextEditingController usernameTextController = TextEditingController();
final TextEditingController ageTextController = TextEditingController();
final TextEditingController placeTextController = TextEditingController();
final TextEditingController numberTextController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF9600FF), Color(0xFFAEBAF8)]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                  "username", Icons.person, false, usernameTextController),
              const SizedBox(
                height: 20,
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
              reusableTextField(
                  "age", Icons.note_alt, false, ageTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "place", Icons.place, false, placeTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("mobile", Icons.mobile_friendly_outlined, false,
                  numberTextController),
              const SizedBox(
                height: 20,
              ),
              signUpButton(context, false, () async {
                //user details
                addUserDetails(
                    usernameTextController.text.trim(),
                    emailTextController.text.trim(),
                    passwordTextController.text.trim(),
                    int.parse(ageTextController.text.trim()),
                    placeTextController.text.trim(),
                    int.parse(numberTextController.text.trim()));

                // await FirebaseAuth.instance
                //     .createUserWithEmailAndPassword(
                //         email: emailTextController.text,
                //         password: passwordTextController.text)
                //     .then((value) {
                //   log("account created successfully");
                // }).onError((error, stackTrace) {
                //   log("error${error.toString()}");
                //   showSimpleNotification(
                //       const Text("Please enter a valide email and password"),
                //       background: Colors.transparent);
                // });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future addUserDetails(String userName, String email, String password, int age,
      String place, int number) async {
        log("entered to function");
    await FirebaseFirestore.instance.collection('user').add({
      'user name': userName,
      'email': email,
      'password': password,
      'age': age,
      'place': number
    }).then((value) {
      log('User datails added successfully');
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    }).onError((error, stackTrace) {
      log("error${error.toString()}");
    });
  }
}
