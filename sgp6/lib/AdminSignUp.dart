import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgp6/AdminHome.dart';

import 'AdminLogin.dart';

class AdminSignUp extends StatefulWidget {
  @override
  _AdminSignUpState createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  String _AdminUsername, _AdminEmail, _AdminPassword, _confirm_password;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('admins');
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  navigateToAdminHome() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminHome()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/shoplogin.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter UserName';
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'UserName',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (input) => _AdminUsername = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(input)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onChanged: (input) => _AdminEmail = input),
                    ),
                    Container(
                      child: TextFormField(
                          controller: _passwordController,
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Provide Minimum 6 Character';
                            }
                            Pattern pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regex = new RegExp(pattern);
                            print(input);
                            if (!regex.hasMatch(input))
                              return 'Enter valid password';
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onChanged: (input) => _AdminPassword = input),
                    ),
                    Container(
                      child: TextFormField(
                          controller: _confirmPasswordController,
                          validator: (input) {
                            if (input != _passwordController.text)
                              return 'Password doesnot match';
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onChanged: (input) => _confirm_password = input),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () async {
                        formkey.currentState.save();
                        if (formkey.currentState.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: _AdminEmail,
                              password: _AdminPassword,
                            );
                            users.doc(_AdminEmail).set({
                              'username': _AdminUsername,
                              'email': _AdminEmail,
                              'pass': _AdminPassword
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHome(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text('SignUp',
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
            ),
          ],
        ),
      ),
    ));
  }
}
