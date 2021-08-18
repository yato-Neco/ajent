import 'dart:async';

import 'package:ajent/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Acontroller.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcreateEND extends StatefulWidget {
  AcreateEND({required this.user, required this.pass, required this.num});

  String? user;

  String? pass;

  int? num;

  @override
  _AcreateEND createState() => _AcreateEND(user, pass, num);
}

class _AcreateEND extends State<AcreateEND> {
  String? pass;
  int? num;
  String? user;

  generate_uuid? uuid_uuid;

  datas? Users;

  _AcreateEND(String? u, String? p, int? n) {
    user = u;
    pass = p;
    num = n;
  }

  @override
  void initState() {
    super.initState();

    _AccountCreate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _AccountCreate() {
    const uuid = Uuid();
    final uuidId = uuid.v1();

    uuid_uuid = generate_uuid(uuidId);

    Users = datas(num, user, uuid_uuid!);

    print(Users!.Users_Datas());

    //もっとマシな関数名つけろ
    void _pWcFLU() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("CwhRGm", pass!.hashCode);
    }

    _pWcFLU();

    void _userNameSave() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", user!);
    }

    _userNameSave();

    void pass_save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("pass", "Unkkokko~Unkoko~");
    }

    void pass_save_hash() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("CwhRGma", 251843923);
    }

    pass_save_hash();
    pass_save();

    Timer(
      Duration(seconds: 5),
      () {
        bool? setUP = true;

        _save() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool("setUP", setUP);
        }

        _save();

        /*

        Navigator.of(context).removeRoute(MaterialPageRoute(builder: (context) {
          return Acreate1();}));

         */

        /*

        Navigator.of(context).removeRoute(MaterialPageRoute(builder: (context) {
          return Acreate2(user: 'None');}));

         */

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(
              title: 'Ajent',
              user: user,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ZoomPageTransitionsBuilder().buildTransitions(
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: 'Ajent',
                            user: user,
                          )),
                  context,
                  animation,
                  secondaryAnimation,
                  child);
            },
          ),
        );

/*
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return MyHomePage(
              title: 'Ajent',
            );
          },
        ),
      );
    });

*/
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Ajent"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),


                child: Text("アカウント作成中"),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
