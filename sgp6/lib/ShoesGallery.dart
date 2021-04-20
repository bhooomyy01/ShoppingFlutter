import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShooesGallary extends StatefulWidget {
  @override
  _ShooesGallaryState createState() => _ShooesGallaryState();
}

class _ShooesGallaryState extends State<ShooesGallary> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Shoes Display",
            style: TextStyle(letterSpacing: 5.0),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('shoes').snapshots(),
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
                        Text(document["Shoes Name"]),
                        Text("Rs. "+document["Shoes Price"]),
                        Text("Colours: "+document["Shoes Colour"]),
                        Text(document["Shoes Description"]),
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
