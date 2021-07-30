import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:socialApp/screens/chat.dart';
import 'package:socialApp/screens/contact.dart';
import 'package:socialApp/screens/home.dart';
import 'package:socialApp/screens/login.dart';
import 'package:socialApp/screens/myimage_cam.dart';
import 'package:socialApp/screens/reg.dart';
import 'package:socialApp/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "mysplash",
    routes: {
      "home": (context) => MyHome(),
      "reg": (context) => MyReg(),
      "login": (context) => MyLogin(),
      "contact": (context) => MyContact(),
      "chat": (context) => MyChat(),
      "myimage": (context) => MyImage(),
      "mysplash": (context) => MySplash(),
    },
  ));
  FlutterStatusbarcolor.setStatusBarColor(Colors.green);
}
