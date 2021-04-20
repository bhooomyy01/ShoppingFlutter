import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgp6/HandbagGallery.dart';

void main() async{
  runApp(AdminHandbagsPage());}

class AdminHandbagsPage extends StatefulWidget {

  @override
  _AdminHandbagsPageState createState() => _AdminHandbagsPageState();
}

class _AdminHandbagsPageState extends State<AdminHandbagsPage> {
  File _image;
  var url;
  final picker = ImagePicker();
  var pickedFile;
  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  String _HandbagName,_HandbagPrice,_HandbagColours,_HandbagDescription;
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
        title: Text("Gallery App"),
        actions: [
          IconButton(icon: Icon(Icons.photo), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HandbagGallery()));
          }),
        ],
      ),

      body: SingleChildScrollView(
        child: Builder(
          key: _globalkey,
          builder: (context) =>  Container(
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
                        child: Container(
                          child: new SizedBox(
                            width: 280.0,
                            height: 300.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://png.pngtree.com/png-clipart/20190618/original/pngtree-cartoon-lady-bag-handbag-illustration-ladies-bag-hand-painted-handbag-png-image_3901893.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),

                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0,left: 0),
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
                      //controller: _ClothName,
                      validator: (value) {
                        if (value.isEmpty) return "Handbag Name can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            )),
                        labelText: "Handbag Name",

                      ),
                      onChanged: (String value){
                        _HandbagName = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      //controller: _Price,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return "Handbag Price can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            )),
                        labelText: "Handbag Price",
                      ),
                      onChanged: (String value){
                        _HandbagPrice = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      //controller: _Colours,
                      validator: (value) {
                        if (value.isEmpty) return "Handbag color can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            )),
                        labelText: "Handbag Colours",
                      ),
                      onChanged: (String value){
                        _HandbagColours = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      // controller: _Description,
                      validator: (value) {
                        if (value.isEmpty) return "Handbag Description can't be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            )),
                        labelText: "Handbag Description",
                      ),
                      onChanged: (String value){
                        _HandbagDescription = value;
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
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        InkWell(
                          onTap: (){
                            if (_globalkey.currentState.validate()){
                              print("Validated!");
                            }
                          },
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              uploadPic(context);
                              FirebaseFirestore.instance.collection("handbags").doc(_HandbagName).set({"Handbag Name":_HandbagName,"Handbag Price":_HandbagPrice,"Handbag Colour":_HandbagColours,"Handbag Description":_HandbagDescription,"url":url});
                            },

                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
