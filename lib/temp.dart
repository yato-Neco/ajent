import 'package:flutter/material.dart';

class Temp extends StatefulWidget {
  @override
  _temp createState() => _temp();
}

class _temp extends State<Temp> {
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
