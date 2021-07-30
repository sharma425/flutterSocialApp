import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              child: MaterialButton(
                minWidth: 200,
                height: 40,
                onPressed: () {
                  Navigator.pushNamed(context, "login");
                },
                child: Text("Login"),
              ),
              color: Colors.amber,
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              child: MaterialButton(
                minWidth: 200,
                height: 40,
                onPressed: () {
                  Navigator.pushNamed(context, "reg");
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
    );
  }
}
