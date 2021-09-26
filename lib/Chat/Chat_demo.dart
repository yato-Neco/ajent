import 'package:ajent/Account/Acontroller.dart';
import 'package:ajent/Chat/Settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_markdown/flutter_markdown.dart';

import '../databace_isar.dart';
import '../isar.g.dart';
import 'package:isar/isar.dart';
import 'package:http/http.dart' as http;

import 'chat_txt_temp.dart';

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

  String? token;

  double chat_byte = 0;

  var _image_data;

  bool Image_faile = false;

  Uint8List? img_buffer;

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
          messagelist.add(MarkDown_Normal(
              markdown: e.user_chat_txt.toString().split("MD:")[1]));
        } else if (e.format_isar == "md") {
          messagelist.add(MarkDown_Normal(
              markdown: e.user_chat_txt.toString().split("MD:")[1]));
        } else if (e.format_isar == "TXT") {
          messagelist.add(TitleChat(
            datas: e.user_chat_txt.toString(),
          ));
        } else if (e.format_isar == "Hint") {
          messagelist.add(Hint());
        }
      });
    });

    var byte = utf8.encode(messagelist.toString());
    var sum = byte.reduce((value, element) => value + element);

    print("${sum / 1000}kb");

    chat_byte = sum / 1000;
  }

  void initState() {
    super.initState();
    FCM();
    Image_faile = false;

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

    token = await messaging.getToken(
      vapidKey:
          "BFrfO2CQfaaXTDdWsi8dTkJkEJoj5sT1lTeUJeW6vdURh5tWv1fpCAcYwxGqh98q-0j0JT7h1CxErteWQwoqxD4",
    );

    print("$token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      String? teke_data = message.data["chat"];

      if (this.mounted) {
        if (teke_data?.startsWith("md:") == true) {
          String? markdown = teke_data?.split("md:")[1];

          format = "md";

          setState(
            () {
              messagelist.add(MarkDown_Normal_uke(
                markdown: markdown,
              ));
            },
          );
        } else if (teke_data?.startsWith("MD:") == true) {
          String? markdown = teke_data?.split("MD:")[1];

          format = "MD";

          setState(
            () {
              messagelist.add(MarkDown_Normal_uke(
                markdown: markdown,
              ));
            },
          );
        }
        if (message.data["IMG"] == true) {
          messagelist.add(Stamp_uke(
              datas: teke_data!, image_data: message.data["IMG_data"]));
        } else {
          setState(
            () {
              format = "TXT";

              messagelist.add(
                TitleChat_uke(
                  datas: teke_data!,
                  time: message.sentTime,
                ),
              );
            },
          );
        }
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

  void save_chat(save_datas) async {
    final isar = await openIsar();

    var data;

    data = user_txt()
      ..user_name = user
      ..format_isar = format
      ..user_chat_txt = save_datas;

    await isar.writeTxn((isar) async {
      await isar.user_txts.put(data); // insert
    });
  }

  void push_txt(chat_txt) {
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = jsonEncode({
      "to": "$token",
      "data": {
        "chat": "$chat_txt",
        "IMG": Image_faile,
        "IMG_data": "${img_buffer}",
      },
      "notification": {"body": "$chat_txt"},
    });

    var server_key =
        "AAAAr8ci_Yo:APA91bGttfG28VeVfAeqYb2wMd_H6_7fptRHxeWy30fKxa9jdo0W1BMe7CfOdL_30eeJwbXiTWFaTCBhNldN7iSye0eX0fKdAU0VeQwxoqDAbbgFFnBRt5g9EZeIUJcMqmsPeSaG7Dgf";

    http
        .post(url,
            headers: {
              "Authorization": "key=${server_key}",
              "project_id": "key=ajent-87d95",
              "Content-Type": "application/json"
            },
            body: body)
        .then((http.Response response) {});
  }

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
          onChanged: (e) {
            token = e;
          },
          decoration: InputDecoration(hintText: "Token"),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SettingChat(
                    token: token.toString(),
                  );
                }));
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
              children: [
                Container(
                    /*
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://images-fe.ssl-images-amazon.com/images/I/A12aAzNhJTL._CR749,0,981,1744_SY1334___SX375_.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),

                   */
                    ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  reverse: true,
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messagelist.length,
                      cacheExtent: 10000.0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: messagelist[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        print("push");

                        final picker = ImagePicker();

                        final pickedFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 1);

                        try {
                          _image_data = File(pickedFile!.path);

                          img_buffer = await _image_data.readAsBytes();

                          ///ByteDataをUint8List変換

                          print("img ${img_buffer?.lengthInBytes}");
                        } catch (e) {
                          print(e);
                        }

                        if (_image_data == null) {
                          Image_faile = false;
                        } else if (_image_data != null) {
                          print(_image_data);
                          Image_faile = true;
                        }
                      },
                      icon: Icon(Icons.publish),
                      splashRadius: 10,
                    ),
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
                        if (datas.startsWith("md:") == true) {
                          String? markdown = datas.split("md:")[1];

                          format = "md";

                          setState(
                            () {
                              messagelist.add(MarkDown_Normal(
                                markdown: markdown,
                              ));
                            },
                          );
                        } else if (datas.startsWith("MD:") == true) {
                          String? markdown = datas.split("MD:")[1];

                          format = "MD";

                          setState(
                            () {
                              messagelist.add(MarkDown_Normal(
                                markdown: markdown,
                              ));
                            },
                          );
                        } else {
                          print(Image_faile);
                          Image_faile = false;
                          setState(
                            () {
                              format = "TXT";

                              messagelist.add(TitleChat(
                                datas: datas,
                              ));
                            },
                          );
                        }
                        //messagelist.add(Stamp(datas: datas,));

                        push_txt(datas);
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
