import 'package:flutter/material.dart';

class Back_1 extends StatefulWidget {
  @override
  _back_1 createState() => _back_1();
}

class _back_1 extends State<Back_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajent"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(),
              onPressed: () {


              },
              child: Text(
                "始める",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
