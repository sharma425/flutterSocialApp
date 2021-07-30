import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class MyContact extends StatefulWidget {
  @override
  _MyContactState createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  var authc = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Contact"),
          actions: [CircleAvatar()],
        ),
        body: ListPage());
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    print("1");
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("imgurl").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading.."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.toString().length,
              itemBuilder: (_, index) {
                print(snapshot.data.toString().length);
                return Card(
                  child: ListTile(
                      // title: Text(snapshot.data[index].data["user"]),
                      ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// class DetailPage extends StatefulWidget {
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
