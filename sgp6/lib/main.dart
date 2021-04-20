import 'package:sgp6/AdminEditProfile.dart';
import 'package:sgp6/AdminHome.dart';
import 'package:sgp6/AdminLogin.dart';
import 'package:sgp6/AdminSignUp.dart';
import 'package:sgp6/BottomNavAccountPage.dart';
import 'package:sgp6/BottomNavCartPage.dart';
import 'package:sgp6/BottomNavChatPage.dart';
import 'package:sgp6/BottomNavFavoritePage.dart';
import 'package:sgp6/BottomNavHomePage.dart';
import 'package:sgp6/Login.dart';
import 'package:sgp6/SignUp.dart';
import 'package:sgp6/Start.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import '';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: Start(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
        "AdminLogin":(BuildContext context)=>AdminLogin(),
        "AdminSingUp":(BuildContext context)=>AdminSignUp(),
        // "AdminHome":(BuildContext)=>AdminHome(),
        // "AdminEditProfile":(BuildContext)=>AdminEditProfile(),
        // "BottomNavHomePage":(BuildContext)=>BottomNavHomePage(),
        // "BottomNavAccountPage":(BuildContext)=>BottomNavAccountPage(),
        // "BottomNavCartPage":(BuildContext)=>BottomNavCartPage(),
        // "BottomNavFavoritePage":(BuildContext)=>BottomNavFavoritePage(),
        // "BottomNavChatPage":(BuildContext)=>BottomNavChatPage()
      },

    );
  }

}