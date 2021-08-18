import 'package:flutter/material.dart';

class Up1 extends StatefulWidget {
  @override
  _up1 createState() => _up1();
}

class _up1 extends State<Up1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
