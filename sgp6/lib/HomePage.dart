import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgp6/BottomNavAccountPage.dart';
import 'package:sgp6/BottomNavCartPage.dart';
import 'package:sgp6/BottomNavChatPage.dart';
import 'package:sgp6/BottomNavFavoritePage.dart';
import 'package:sgp6/BottomNavHomePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex=2;
   final List<Widget> _children = [
    BottomNavAccountPage(),
    BottomNavFavoritePage(),
    BottomNavHomePage(),
    BottomNavChatPage(),
    BottomNavCartPage(),
  ];

  void onTappedBar (int index){
          setState(() {
            _currentIndex=index;
          });
        }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:_children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Text("Account"),
              backgroundColor: Colors.orangeAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favorite"),
              backgroundColor: Colors.redAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.blueGrey
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text("Chat"),
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Cart"),
              backgroundColor: Colors.teal
          ),
        ],

      ),
    );
  }


}
