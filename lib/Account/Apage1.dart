import 'package:ajent/Account/Apage2.dart';
import 'package:ajent/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Account_create.dart';

class Acreate1 extends StatefulWidget {
  @override
  _create1 createState() => _create1();
}

class _create1 extends State<Acreate1> {
  String? user;

  void info_user(String e) {
    user = e;
    print("user: ${user} user-hash ${user.hashCode} ");
  }

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
            /*
            TextButton(
              style: ButtonStyle(),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ),
                );
              },
              child: Text(
                "User-name",
                style: TextStyle(fontSize: 30),
              ),
            ),*/
            TextField(
              maxLengthEnforcement: MaxLengthEnforcement.none,
              enabled: true,
              // 入力数
              autofocus: true,
              maxLength: 10,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                hintText: 'user-name',
                labelText: 'user-name *',
              ),
              //パスワード
              onChanged: info_user,
            ),
            TextButton(
              onPressed: () {
                if ((user == null) || (user == "")) {

                  final snackBar = SnackBar(

                    content: Text('名前を入れてください'),
                    action: SnackBarAction(
                      label: '閉じる',
                      onPressed: () {


                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);



                }else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Acreate2(
                      user: user!,
                    );
                  }));
                }
              },
              child: Text(
                "Next",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
