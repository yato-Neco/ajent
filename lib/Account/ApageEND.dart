import 'dart:async';

import 'package:ajent/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';

import '../databace_isar.dart';
import '../isar.g.dart';
import 'Acontroller.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method



class AcreateEND extends StatefulWidget {
  AcreateEND({required this.user, required this.pass, required this.num});

  String? user;

  String? pass;

  int? num;

  @override
  _AcreateEND createState() => _AcreateEND(user, pass, num);
}

class MapChangeList {

  String? key;
  String? vule;


  MapChangeList(this.key,this.vule);
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

    Map? user_datas = Users?.Users_Datas();




    //もっとマシな関数名つけろ
    void _pWcFLU() async {

      final storage = new FlutterSecureStorage();

      var bytes = utf8.encode(pass!); // data being hashed
      var digest = sha512.convert(bytes);


      print("Digest as bytes: ${digest.bytes}");
      print("Digest as hex string: $digest");


      await storage.write(key: 'CwhRGm', value: digest.toString());

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

    isar_save() async {
      final isar = await openIsar();

      var setting;

      setting = fstPage_isar()
        ..setUP = true
        ..locled = true
        ..passcode = false
        ..seitai = false
        ..id = 0
        ..fstPage_setting = []
      ;


      await isar.writeTxn((isar) async {
        await isar.fstPage_isars.put(setting); // insert
      });

      var userData;
      List<String>? list = user_datas?.entries.map((e) => "${e.key}: ${e.value}").toList();

      print(list is List<String>?);



      userData = user_data_isar()
      ..id = 0
      ..user_name = user
      ..number = num
      ..uuid = uuidId
      ..user_data = list;

      await isar.writeTxn((isar) async {
        await isar.user_data_isars.put(userData); // insert
      });


    }

    isar_save();

    Timer(
      Duration(seconds: 5),
      ()  {






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
