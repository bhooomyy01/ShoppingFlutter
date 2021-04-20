import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';


void main() async{
  runApp(AdminEditProfile());}

class AdminEditProfile extends StatefulWidget {

  @override
  _AdminEditProfileState createState() => _AdminEditProfileState();
}

class _AdminEditProfileState extends State<AdminEditProfile> {
  File _image;
  var url;
  final picker = ImagePicker();
  var pickedFile;
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  final User adminuser = FirebaseAuth.instance.currentUser;
  String _AdminName,_AdminEmail,_AdminUsername,_AdminDOB;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('admins');

  @override
  Widget build(BuildContext context) {
    Future getImage(BuildContext context) async {
      pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedFile.path);
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);

      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('uploads/$fileName');
      firebase_storage.UploadTask uploadTask =
      firebaseStorageRef.putFile(_image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      firebaseStorageRef.getDownloadURL().then((fileUrl) => url = fileUrl);
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Builder(
          key: _globalkey,
          builder: (context) =>
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Color(0xffdadde7),
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 200.0,
                                  height: 200.0,
                                  child: (_image != null) ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  ) : Image.network(
                                    "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 135.0, left: 0),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  getImage(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Name can't be empty";
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                )),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                            labelText: "Name",
                            hintText: "Name",
                          ),
                          onChanged: (String value) {
                            _AdminName = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                            labelText: "Username",
                            hintText: "Username",
                          ),
                          onChanged: (String value) {
                            _AdminUsername = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          // validator: (value) {
                          //   if (value.isEmpty) return "Email can't be empty";
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                )),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                            labelText: "Email",
                            hintText: "Email",
                          ),
                          onChanged: (String value) {
                            _AdminEmail = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "DOB can't be empty";
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                )),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                            labelText: "Location",
                            hintText: "Location",
                          ),
                          onChanged: (String value) {
                            _AdminDOB = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        // ignore: deprecated_member_use
                        Row(
                          children: [
                            SizedBox(
                              width: 90.0,
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              elevation: 4.0,
                              splashColor: Colors.blueGrey,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            InkWell(
                              onTap: () {
                                if (_globalkey.currentState.validate()) {
                                  print("Validated!");
                                }
                              },
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  uploadPic(context);
                                  collectionReference.doc(_AdminEmail)
                                      .update({
                                    "name": _AdminName,
                                    "username": _AdminUsername,
                                    "email": _AdminEmail,
                                    "location":_AdminDOB,
                                    "url": url
                                  });
                                },

                                elevation: 4.0,
                                splashColor: Colors.blueGrey,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}


 /* File _image;
  var url;
  final picker = ImagePicker();
  var pickedFile;
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  final User adminuser = FirebaseAuth.instance.currentUser;
  String _AdminName,_AdminEmail,_AdminUsername,_AdminDOB;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('admins');

  @override
  Widget build(BuildContext context) {
    Future getImage(BuildContext context) async {
      pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedFile.path);
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);

      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('uploads/$fileName');
      firebase_storage.UploadTask uploadTask =
      firebaseStorageRef.putFile(_image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      firebaseStorageRef.getDownloadURL().then((fileUrl) => url = fileUrl);
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Builder(
            key: _globalkey,
            builder: (context) =>
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Color(0xffdadde7),
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 200.0,
                                    height: 200.0,
                                    child: (_image != null) ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    ) : Image.network(
                                      "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 135.0, left: 0),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    getImage(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return "Name can't be empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.teal,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  )),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                              labelText: "Name",
                              hintText: "Name",
                            ),
                            onChanged: (String value) {
                              _AdminName = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.teal,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                              labelText: "Username",
                              hintText: "Username",
                            ),
                            onChanged: (String value) {
                              _AdminUsername = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            // validator: (value) {
                            //   if (value.isEmpty) return "Email can't be empty";
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.teal,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  )),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                              labelText: "Email",
                              hintText: "Email",
                            ),
                            onChanged: (String value) {
                              _AdminEmail = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return "DOB can't be empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.teal,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  )),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                              labelText: "DOB",
                              hintText: "DOB",
                            ),
                            onChanged: (String value) {
                              _AdminDOB = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          // ignore: deprecated_member_use
                          Row(
                            children: [
                              SizedBox(
                                width: 90.0,
                              ),
                              RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                elevation: 4.0,
                                splashColor: Colors.blueGrey,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_globalkey.currentState.validate()) {
                                    print("Validated!");
                                  }
                                },
                                child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    uploadPic(context);
                                    collectionReference.doc(_AdminEmail)
                                        .update({
                                      "username": _AdminName,
                                      "userusername": _AdminUsername,
                                      "useremail": _AdminEmail,
                                      "location":_AdminDOB,
                                      "url": url
                                    });
                                  },

                                  elevation: 4.0,
                                  splashColor: Colors.blueGrey,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      );
    }
  }
*/