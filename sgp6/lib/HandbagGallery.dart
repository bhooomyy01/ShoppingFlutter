import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'ClothGallary.dart';

void main() async{
  runApp(HandbagGallery());}

class HandbagGallery extends StatefulWidget {

  @override
  _HandbagGalleryState createState() => _HandbagGalleryState();
}

class _HandbagGalleryState extends State<HandbagGallery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Handbag Display",
            style: TextStyle(letterSpacing: 5.0),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('handbags').snapshots(),
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
                        Text(document["Handbag Name"]),
                        Text("Rs. "+document["Handbag Price"]),
                        Text("Available Colour: "+document["Handbag Colour"]),
                        Text(document["Handbag Description"]),
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