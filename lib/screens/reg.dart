import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyReg extends StatefulWidget {
  @override
  MyRegState createState() => MyRegState();
}

class MyRegState extends State<MyReg> {
  String password;

  String email;

  bool spin = false;

  var authc = FirebaseAuth.instance;
  var fs = FirebaseFirestore.instance;

  File imagepath;
  var imageurl;
  var furl;
  var defaultImg =
      "https://firebasestorage.googleapis.com/v0/b/fir-44f31.appspot.com/o/userlogo.PNG?alt=media&token=6090fe6c-65d6-40b9-a881-442167a44983";
  clickphoto() async {
    var picker = ImagePicker();
    var image = await picker.getImage(
        source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    var w = image.path;
    print(w.runtimeType);
    setState(() {
      imagepath = File(image.path);
    });
    var firebaseStorage =
        FirebaseStorage.instance.ref().child("ProfilePicture").child("my.jpg");
    firebaseStorage.putFile(imagepath);
    imageurl = await firebaseStorage.getDownloadURL();
    setState(() async {
      furl = imageurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: furl != null
                    ? NetworkImage(furl)
                    : NetworkImage(defaultImg),
              ),
              RaisedButton(
                onPressed: clickphoto,
                child: Text("Click Here"),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Input Your Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Input Your Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 15),
              Material(
                child: MaterialButton(
                  minWidth: 200,
                  height: 40,
                  onPressed: () async {
                    setState(() {
                      spin = true;
                    });
                    try {
                      print("then");
                      var signin = await authc.createUserWithEmailAndPassword(
                          email: email, password: password);
                      await fs
                          .collection("imgurl")
                          .add({"profileImage": furl, "user": email});
                      print(signin.additionalUserInfo.isNewUser);

                      if (signin.additionalUserInfo.isNewUser == true) {
                        setState(() {
                          spin = false;
                        });

                        Navigator.pushNamed(context, "login");
                      } else {
                        print("object");
                      }
                    } catch (e) {
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  child: Text("Register"),
                ),
                color: Colors.amber,
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
