import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClothGallary extends StatefulWidget {
  @override
  _ClothGallaryState createState() => _ClothGallaryState();
}

class _ClothGallaryState extends State<ClothGallary> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cloth Display",
            style: TextStyle(letterSpacing: 5.0),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cloths').snapshots(),
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
                        Image.network(
                          document.get("url"),
                          height: 150,
                          width: 150,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        Text(document["Cloth Name"]),
                        Text("Rs." + document["Cloth Price"]),
                        Text("Available Colour: " + document["Cloth Colour"]),
                        Text(document["Cloth Description"])
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

/*FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.collection("images").snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError ? Center(
              child: Text("There is some problem loading your images"),) :
            snapshot.hasData ?
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              children: snapshot.data.docs.map((e) => Image.network(e.get("url"))).toList(),
            ) : Container();
          },
        ),
      ),

    );
  }
}

   */
