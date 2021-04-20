import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgp6/AdminHome.dart';
import 'AdminSignUp.dart';

class AdminLogin extends StatefulWidget {
  static String email;

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String _AdminEmail, _AdminPassword;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToAdminSignUp() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminSignUp()));
  }

  navigateToAdminHome() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/shoplogin.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _AdminEmail = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 Character';
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _AdminPassword = input),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () async {
                        formkey.currentState.save();
                        if (formkey.currentState.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: _AdminEmail,
                                    password: _AdminPassword);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHome(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                      },
                      child: Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Text('Click Here To Create an Admin Account'),
                onTap: navigateToAdminSignUp,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
