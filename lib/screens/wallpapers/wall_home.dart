import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class WallHome extends StatefulWidget {
  const WallHome({super.key});

  @override
  State<WallHome> createState() => _WallHomeState();
}

class _WallHomeState extends State<WallHome> {
  StreamSubscription<QuerySnapshot>?subscription;
  List<DocumentSnapshot>?wallpapersList;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("wallpaperes");
  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((event) { 
      setState(() {
        wallpapersList = event.docs;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("WallPexals"),
      ),
      body: wallpapersList != null?
      StaggeredGridView.countBuilder(
        padding:const EdgeInsets.all(8.0),
        crossAxisCount:4,
        itemCount: wallpapersList!.length,
        itemBiulder:(context,index){
          String imagePath = wallpapersList[index].data['url'];
          return Material(
            elevation: 8.0,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Hero(
              tag: imagePath,
              child: FadeInImage(
                placeholder: placeholder,
                 image: NetworkImage(imagePath)),
            ),); 
        }
      ),
    );
  }
}