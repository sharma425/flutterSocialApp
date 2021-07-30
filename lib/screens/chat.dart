import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'reg.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var authc = FirebaseAuth.instance;
  var user;
  var fs = FirebaseFirestore.instance;

  var chatMsg;
  var profileUrl;

  var mrs = MyRegState();

  var msgTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = authc.currentUser.email;
    print(user);

    profileImage() {
      FutureBuilder<DocumentSnapshot>(
        future: fs.collection("imgurl").doc(user).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print(data['profileImage']);
            return Text(
                "Full Name: ${data['profileImage']} {data['last_name']}");
          }

          return Text("loading");
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Chat"),
        actions: [
          CircleAvatar(backgroundImage: profileImage())
          // CircularProgressIndicator(),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fs
                .collection("chat")
                .orderBy('timeStamp', descending: false)
                .where("sender", isEqualTo: user)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return CircularProgressIndicator();
              var msg = snapshot.data.docs;

              List<Widget> y = [];
              for (var d in msg) {
                var msgText = d.data()['text'];
                var msgSender = d.data()['sender'];
                var msgWidget = Text("This $msgText comes from $msgSender");
                y.add(msgWidget);
              }
              print(y);
              var w = Container(
                child: Column(
                  children: y,
                ),
              );
              return w;
            },
          ),
          Card(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Type here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onChanged: (value) {
                      chatMsg = value;
                    },
                    controller: msgTextController,
                  ),
                ),
                Material(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    height: 40,
                    onPressed: () async {
                      var date = new DateTime.now().toString();
                      var timeStamp =
                          DateTime.parse(date).millisecondsSinceEpoch;
                      msgTextController.clear();
                      await fs.collection("chat").add({
                        "text": chatMsg,
                        "sender": authc.currentUser.email,
                        "timeStamp": timeStamp
                      });
                    },
                    child: Text("send"),
                  ),
                  color: Colors.amber,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
