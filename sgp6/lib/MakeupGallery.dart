import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() async{
  runApp(MakeupGallery());}

class MakeupGallery extends StatefulWidget {

  @override
  _MakeupGalleryState createState() => _MakeupGalleryState();
}

class _MakeupGalleryState extends State<MakeupGallery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Makeup Display",
            style: TextStyle(letterSpacing: 5.0),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('makeup').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Row(
                  children: <Widget>[
                    Column(
                      children: [
                        Image.network(document.get("url"),height: 150,width: 150,),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(document["Makeup Name"]),
                        Text("Rs."+document["Makeup Price"]),
                        Text(document["Makeup Description"]),
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                    )
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
