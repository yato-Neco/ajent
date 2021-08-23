import 'package:flutter/material.dart';

class Up1 extends StatefulWidget {
  @override
  _up1 createState() => _up1();
}

class _up1 extends State<Up1> {

  var text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [

          ListTile(

            title: Text("デモ1"),
            subtitle: Text("$text"),
            onTap: (){

            },
            trailing: null,
          ),
          ListTile(

            title: Text("デモ2"),
            subtitle: Text("$text"),
            onTap: (){

            },
            trailing: null,
          ),
          ListTile(

            title: Text("デモ3"),
            subtitle: Text("$text"),
            onTap: (){

            },
            trailing: null,
          ),
          ListTile(

            title: Text("デモ4"),
            subtitle: Text("$text"),
            onTap: (){

            },
            trailing: null,
          ),

        ],
      )
    );
  }
}
