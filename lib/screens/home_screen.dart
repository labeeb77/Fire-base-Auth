import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_sample/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Home",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(child: 
      Center(
        child: ElevatedButton(onPressed: () async{

         await FirebaseAuth.instance.signOut().then((value) {
            log("Sign out");
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen(),));

         });
         
        }, child: Text("Log out")),
      )),
      
    );
  }
}