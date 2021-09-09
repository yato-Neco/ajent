import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter_markdown/flutter_markdown.dart';

import '../databace_isar.dart';
import '../isar.g.dart';
import 'package:isar/isar.dart';




String datas = "";
var size;

class TestPage2 extends StatefulWidget {
  String? user;

  TestPage2(String s) {
    user = s;
  }

  @override
  NTestPage2 createState() => NTestPage2(user);
}

class NTestPage2 extends State<TestPage2> {
  bool? networktf;

  int hint = 0;

  String? user;

  String? format;

  List<Widget> messagelist = [];


  int? test;

  NTestPage2(String? u) {
    user = u;

    user_c();
  }

  @override
  void dispose() {
    super.dispose();

    messagelist.clear();
  }

  void user_c() async {

    INts_get() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print((prefs.getInt("hint")));
      hint = (prefs.getInt("hint") ?? 0);
      return hint;
    }

    if (await INts_get() == 0) {
      format = "Hint";

      final isar = await openIsar();

      var data;

      data = user_txt()
        ..user_name = user
        ..format_isar = format
        ..user_chat_txt = null;

      await isar.writeTxn((isar) async {
        await isar.user_txts.put(data); // insert
      });
    }







    user_c_t() async {
      final isar = await openIsar();

      final user_txt = isar.user_txts;

      final allContacts = await user_txt.where().findAll();

      return allContacts;
    }

    var w = await user_c_t();

    w.forEach((e) {
      setState(() {
        if (e.format_isar == "MD") {
          messagelist
              .add(MarkDown_Normal(e.user_chat_txt.toString().split("MD:")[1]));
        } else if (e.format_isar == "md") {
          messagelist
              .add(MarkDown_Normal(e.user_chat_txt.toString().split("md:")[1]));
        } else if (e.format_isar == "TXT") {
          messagelist.add(
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: (size.width / 1.1),
                    ),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(7.0),
                        child: SelectableText(
                          "${e.user_chat_txt.toString()}",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ]),
          );
        }else if(e.format_isar == "Hint"){
          messagelist.add(Hint());

        }

      });
    });

    var byte = utf8.encode(messagelist.toString());
    var sum = byte.reduce((value, element) => value + element);



    print("${sum / 1000}kb" );
  }

  void sarv(data) {
    messagelist.add(
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: (size.width / 1.1),
              ),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "$data",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void set() {
    setState(() {});
  }

  void initState() {
    super.initState();
    //FCM();


    HINT_LOAD();
  }



  void FCM() async {


    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');


    String? token = await messaging.getToken(
      vapidKey: "BFrfO2CQfaaXTDdWsi8dTkJkEJoj5sT1lTeUJeW6vdURh5tWv1fpCAcYwxGqh98q-0j0JT7h1CxErteWQwoqxD4",
    );

    print("$token");


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data.toString()}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });


  }





  void HINT_LOAD() async {


    void INts() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("hint", hint + 1);
    }

    INts();
  }

  void textdata(String e) {
    datas = e;
    print(datas.length);
  }

/*
  void ip(String p) {
    void NTTF() {
      if (p == "") {
        networktf = false;
        print(p);
      } else {
        networktf = true;
      }
    }

    setState(() {
      var ipandprot = p.split(":");
      print(ipandprot);
      ipv4 = ipandprot[0];
      NTTF();

      try {
        port = int.parse(ipandprot[1]);
      } catch (e) {
        print(e);
        port = 6000;
      }
    });
  }

 */

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - padding.top - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height - padding.top - padding.bottom - 22;
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (e) {},
          decoration: InputDecoration(hintText: "IP:Port"),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                reverse: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: messagelist.length,
                  cacheExtent: 10000.0,
                  itemBuilder: (BuildContext context, int index) {
                    return messagelist[index];
                  },
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(onPressed: () {}, icon: Icon(Icons.face)),
                    Flexible(
                      child: TextField(
                        enabled: true,
                        maxLength: 355,
                        maxLines: 3,
                        minLines: 1,
                        maxLengthEnforcement:
                            MaxLengthEnforcement.truncateAfterCompositionEnds,
                        obscureText: false,
                        autofocus: false,
                        onChanged: textdata,
                        decoration: InputDecoration(hintText: "None"),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (datas.split("md:")[0] == "") {
                          String? markdown = datas.split("md:")[1];

                          format = "md";

                          setState(
                            () {
                              messagelist.add(MarkDown_Normal(markdown));
                            },
                          );
                        } else if (datas.split("MD:")[0] == "") {
                          String? markdown = datas.split("MD:")[1];

                          format = "MD";

                          setState(
                            () {
                              messagelist.add(MarkDown_Normal(markdown));
                            },
                          );
                        } else {
                          setState(
                            () {
                              format = "TXT";

                              messagelist.add(
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: (size.width / 1.1),
                                        ),
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(7.0),
                                            child: SelectableText(
                                              "$datas",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              );
                            },
                          );
                        }




                        final isar = await openIsar();

                        var data;

                        data = user_txt()
                          ..user_name = user
                          ..format_isar = format
                          ..user_chat_txt = datas;

                        await isar.writeTxn((isar) async {
                          await isar.user_txts.put(data); // insert
                        });
                      },
                      child: Text("Enter"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MarkDown_Normal extends StatelessWidget {
  String? markdown;

  MarkDown_Normal(String m) {
    markdown = m;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (size.width / 1.1),
          ),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(7.0),
              child: MarkdownBody(data: '$markdown', selectable: true),
              /*
                                          Text(

                                            "$datas",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                               */
            ),
          ),
        ),
      ],
    );
  }
}

class Hint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
      margin: EdgeInsets.all(25),
      child: Text(
        "MarkDown(GFM) Hint 💡 \n [md: or MD:] \n [MD:# 見出し] [MD:- 箇条書き] [MD: 1. 番号付き] "
            "\n [MD: `code記法`] [MD: *強調*] [MD: **強調2**] "
            "\n [MD: ***強調3***] [MD: *** 水平線] [MD: ~~取り消し線~~] etc...",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black.withOpacity(0.5)),
      ),
    );
  }
}
