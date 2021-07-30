import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;

  String password, email;

  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      var login = await authc.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (login.user.isAnonymous == false) {
                        setState(() {
                          spin = false;
                        });
                        Navigator.pushNamed(context, "contact");
                      } else {
                        print("object");
                      }
                    } catch (e) {
                      Toast.show("Invalid Username or Password", context);
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  child: Text("Login"),
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
