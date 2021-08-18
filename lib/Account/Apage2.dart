
import 'package:ajent/Account/Apage1.dart';
import 'package:ajent/Account/ApageEND.dart';
import 'package:ajent/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'Account_create.dart';

class Acreate2 extends StatefulWidget {
  Acreate2({required this.user});

  String user;

  @override
  _create2 createState() => _create2(user);
}

class _create2 extends State<Acreate2> {
  String? pass;
  int? num;
  String? user;

  _create2(String u) {
    user = u;
  }

  void info_pass(String? e) {
    pass = e;
  }
//バグあり
  //最初入力して消したら、最初の数値が残ってる
  void info_num(String? e) {
    try {
      setState(() {
        num = int.parse(e!);
      });
      print(e);
    } on FormatException {
      num = null;

      final snackBar = SnackBar(
        content: Text(
          '数字を入力してください',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } catch (e) {
      print(e);
    }
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
                "PassWord",
                style: TextStyle(fontSize: 30),
              ),
            ),*/
            TextField(
              keyboardType: TextInputType.visiblePassword,
              maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              enabled: true,
              autofocus: true,
              // 入力数
              maxLength: 15,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              decoration: const InputDecoration(

                icon: Icon(Icons.title),
                hintText: 'password',
                labelText: 'password *',
              ),
              //パスワード
              onChanged: info_pass,
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              enabled: true,
              // 入力数

              maxLength: 5,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 1,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                hintText: '好きな数字を入力してください',
                labelText: '数字 *',
              ),
              //パスワード
              onChanged: info_num,
            ),
            TextButton(
              onPressed: () {
                if (((pass == null) || (pass == "")) || (num == null)){
                  print(user);

                  final snackBar = SnackBar(
                    content: Text('全項目入力してください'),
                    action: SnackBarAction(
                      label: '閉じる',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if(pass!.length <= 6){
                  final snackBar = SnackBar(
                    content: Text('パスワードを7桁以上にしてください'),
                    action: SnackBarAction(
                      label: '閉じる',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);


                }

                else if((pass!.length >= 7) && (num != null)) {





                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AcreateEND(
                      user: user!,
                      pass: pass!,
                      num: num!,
                    );
                  }));

                } else{
                  final snackBar = SnackBar(
                    content: Text('エラーが発生しました再度入力してください'),

                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
