import 'dart:async';

import 'package:ajent/Settings_f/User_Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../main.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'Lock_Controller.dart'; // for the utf8.encode method


bool? comeback;




class LockScreen extends StatefulWidget {
  bool pop = false;

  LockScreen(bool p) {
    pop = p;
  }

  @override
  _lockscreen createState() => _lockscreen(pop);
}

class _lockscreen extends State<LockScreen> {
  String? haspeg;

  String? CwhRGm;

  bool pop = false;

  bool enabled = true;

  _lockscreen(p) {
    pop = p;
  }

  GetPassHash() async {


    final storage = new FlutterSecureStorage();


    var asdaw = await storage.read(key: 'CwhRGm');

    print(asdaw);


    return asdaw.toString();
  }

  void _SetPassHash() async {
    CwhRGm = await GetPassHash();
  }

  @override
  void initState() {
    _SetPassHash();

    print("locked------------------");

    lockScreen = lock_controller(null, false, true);


    comeback = true;
    print("1");



    super.initState();
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
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.visiblePassword,
                maxLengthEnforcement:
                    MaxLengthEnforcement.truncateAfterCompositionEnds,
                enabled: enabled,
                autofocus: true,
                //入力する文字色を決める
                cursorColor: Colors.white,
                // 入力数
                maxLength: 15,
                //style: TextStyle(color: Colors.black),
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
                onChanged: (e) {


                  var bytes = utf8.encode(e); // data being hashed
                  var digest = sha512.convert(bytes);

                  haspeg = digest.toString();

                  if (CwhRGm == haspeg) {
                    if (pop == true) {
                      setState(() {
                        enabled = false;
                      });

                      Timer(
                        Duration(milliseconds: 500),
                        () {
                          Navigator.pop(
                            context,
                            false
                          );
                        },
                      );
                    } else if (pop == false) {

                      setState(() {
                        enabled = false;
                      });

                      Timer(
                        Duration(milliseconds: 500),
                        () {
                          Navigator.pushReplacement(

                            context,

                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      MyHomePage(
                                title: 'Ajent',
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ZoomPageTransitionsBuilder()
                                    .buildTransitions(
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                      title: 'Ajent',
                                    ),
                                  ),
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                );
                              },

                            ),

                          );

                        },
                      );
                    }
                  }
                },
              ),
              TextButton(
                style: ButtonStyle(),
                onPressed: () {
                  if (CwhRGm == haspeg) {
                    if (pop == true) {
                      Navigator.pop(
                        context,
                        false
                      );
                    } else if (pop == false) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MyHomePage(
                            title: 'Ajent',
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return ZoomPageTransitionsBuilder()
                                .buildTransitions(
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                        title: 'Ajent',
                                      ),
                                    ),
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child);
                          },
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "LockScreen",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
