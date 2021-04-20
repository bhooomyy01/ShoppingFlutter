import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgp6/BottomNavAccountPage.dart';
import 'package:sgp6/ClothGallary.dart';
import 'package:sgp6/AdminHome.dart';
import 'package:sgp6/BottomNavCartPage.dart';
import 'package:sgp6/HandbagGallery.dart';
import 'package:sgp6/MakeupGallery.dart';
import 'package:sgp6/ShoesGallery.dart';
import 'package:sgp6/Start.dart';

class BottomNavHomePage extends StatefulWidget {
  @override
  _BottomNavHomePageState createState() => _BottomNavHomePageState();
}

class _BottomNavHomePageState extends State<BottomNavHomePage> {
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
        context, MaterialPageRoute(builder: (context) => BottomNavAccountPage()));
  }

  navigateToClothsPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClothGallary()));
  }

  navigateToHandBagsPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HandbagGallery()));
  }

  navigateToMakeUpPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MakeupGallery()));
  }

  navigateToShoesPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShooesGallary()));
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
                    else if (title == "Shoes")
                      navigateToShoesPage();
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

/*
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  List<String> categories = [
    "Dress",
    "Handbag",
    "Makeup",
    "Shoes",
    "Watch",
    "Hats"
  ];
  int selectIndex = 0;


  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    // final googleSignIn = GoogleSignIn();
    //await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  Widget build(BuildContext context){
    return new Scaffold(
      body: SingleChildScrollView(
        child: !isloggedin
        ? CircularProgressIndicator()
        : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  height: 30,
                  /*child: Image(
                  image: AssetImage("images/welcome.jpg"),
                  fit: BoxFit.contain,
                ),*/
                ),
                SizedBox(
                  height: 30,
                  child: GestureDetector(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => buildCategory(index),
                    ),
                    onTap: () {
                      setState(() {
                        print(categories[selectIndex]);
                        if(categories[selectIndex]=="Dress"){
                            Text("Dress");
                        }
                        // else if(categories[selectIndex]=="HandBag")
                        //
                        // else if(categories[selectIndex]=="Makeup")
                        //
                        // else if(categories[selectIndex]=="Shoes")

                      });
                      //Text("Dress",style: TextStyle(fontSize: 200,height: 200),);
                    },
                  ),
                ),

                Container(width: 55.0,height: 50),
                Row(
                  children: [
                    SizedBox(
                      width: 240.0,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      onPressed: signOut,
                      child: Text('Signout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),

    );
  }
  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Container(
              margin: EdgeInsets.only(top: 25 / 4),
              height: 2,
              width: 30,
              color: selectIndex== index ? Colors.black87 : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
  Widget Dress(){

  }
}

 */