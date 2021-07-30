import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImage extends StatefulWidget {
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  File imagepath;
  var imageurl;
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
    var firebaseStorage = FirebaseStorage.instance.ref().child("myimage2");
    firebaseStorage.putFile(imagepath);
    setState(() async {
      imageurl = await firebaseStorage.getDownloadURL();
      print(imageurl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: clickphoto,
        child: Icon(Icons.photo),
      ),
      appBar: AppBar(
        title: Text("Image"),
        actions: [
          CircleAvatar(
            backgroundImage: imageurl == null
                ? NetworkImage(defaultImg)
                : NetworkImage(imageurl),
          )
        ],
      ),
      body: Container(
        height: 200,
        width: 200,
        color: Colors.amberAccent,
        child:
            imagepath == null ? Text("Set Our Image") : Image.file(imagepath),
      ),
    );
  }
}
