import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgp6/AdminClothsPage.dart';
import 'package:sgp6/AdminEditProfile.dart';
import 'package:sgp6/AdminHandbagsPage.dart';
import 'package:sgp6/AdminMakeUpPage.dart';
import 'package:sgp6/AdminShoesPage.dart';
import 'package:sgp6/Start.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(AdminHome());

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  List<String> events = [
    "Cloths",
    "Handbags",
    "Makeup",
    "Shoes",
    "Watch",
    "Sunglasses"
  ];

  navigateToAdminEditProfile() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminEditProfile()));
  }

  navigateToClothsPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminClothsPage()));
  }

  navigateToHandBagsPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminHandbagsPage()));
  }

  navigateToMakeUpPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminMakeUpPage()));
  }

  navigateToShoesPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminShoesPage()));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('X Garments'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            SizedBox(width: 260),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Start(),
                  ),
                );
              },
            ),
          ],
        ),

        /*Drawer(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('admins').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Column(
                    children: <Widget>[
                      DrawerHeader(
                        child: Image.network(
                          document.get("url"),
                          height: 50,
                          width: 50,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        title: Text("Name: "+document["name"]),
                      ),
                      ListTile(
                        title: Text("Username: "+document["username"]),
                      ),
                      ListTile(
                        title: Text("Email: "+document["email"]),
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
        ),*/
        drawer: Drawer(
          elevation: 50.0,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('admins').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.

              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      DrawerHeader(
                        child: Column(
                          children: [
                            Image.network(
                              document.get("url"),
                              height: 135,
                              width: 250,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: Text("Name: " + document["name"]),
                      ),
                      ListTile(
                        title: Text("Username: " + document["username"]),
                      ),
                      ListTile(
                        title: Text("Email: " + document["email"]),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      RaisedButton(
                        onPressed: navigateToAdminEditProfile,
                        child: Text('Edit Profile',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/welcome.jpg"), fit: BoxFit.cover)),
          child: Container(
            margin: const EdgeInsets.only(top: 120.0),
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: events.map((title) {
                return GestureDetector(
                  child: Card(
                      margin: const EdgeInsets.all(20.0),
                      child: getCardByTitle(title)),
                  onTap: () {
                    if (title == "Cloths")
                      navigateToClothsPage();
                    else if (title == "Handbags")
                      navigateToHandBagsPage();
                    else if (title == "Makeup")
                      navigateToMakeUpPage();
                    else if (title == "Shoes") navigateToShoesPage();
                    /*else if (title == "Watch")
                      navigateToWatchPage();
                    else if (title == "Sunglasses")
                      navigateToSunglassesPage();*/
                    /*Fluttertoast.showToast(msg: title + " click ",
                  toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );*/
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Cloths")
      img = "images/cloth.jpg";
    else if (title == "Handbags")
      img = "images/handbag.jpg";
    else if (title == "Makeup")
      img = "images/makeup.jpg";
    else if (title == "Shoes")
      img = "images/shoes.jpg";
    else if (title == "Watch")
      img = "images/watch.jpg";
    else if (title == "Sunglasses") img = "images/sunglasses.jpeg";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  img,
                  width: 80.0,
                  height: 80.0,
                )
              ],
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
