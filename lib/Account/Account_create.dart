import 'package:ajent/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Apage1.dart';

class Acreate extends StatefulWidget {
  @override
  _create createState() => _create();
}

class _create extends State<Acreate> {
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

                /*
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Acreate1(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return ZoomPageTransitionsBuilder().buildTransitions(
                          MaterialPageRoute(builder: (context) => Acreate1()),
                          context,
                          animation,
                          secondaryAnimation,
                          child);
                    },
                  ),
                );

                */


                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Acreate1();
                }));


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
