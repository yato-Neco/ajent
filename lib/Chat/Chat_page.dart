import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../databace_isar.dart';
import '../isar.g.dart';
import 'package:isar/isar.dart';

import 'package:http/http.dart' as http;

import 'Settings.dart';
import 'chat_txt_temp.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class Chat_page extends StatefulWidget {
  String? user;

  String? partner;

  String? Token;

  var uuid_hash;

  Chat_page({this.user, this.partner, this.Token, this.uuid_hash});

  @override
  _chat_page createState() =>
      _chat_page(user: user, partner: partner, Token: Token, uuid_hash: uuid_hash);
}

class _chat_page extends State<Chat_page> {
  String? user;

  String? partner;

  List messagelist = [];

  String? txt;

  var uuid_hash;

  var token;

  String? Token;

  _chat_page({this.user, this.partner, this.Token, this.uuid_hash});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("$partner"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SettingChat(
                      token: token.toString(),
                    );
                  },
                ),
              ).then((value) {
                setState(() {
                  messagelist.clear();
                  messagelist.add(Hint());
                  Load_txt();
                });
              });
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: EdgeInsets.only(top: 6, bottom: 6),
                            child: messagelist[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  color: Colors.black12.withOpacity(1.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {},
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
                          onChanged: TXT,
                          onTap: () {
                            print("click");
                          },
                          decoration: InputDecoration(hintText: "None"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          PushTxt(txt);
                        },
                        child: Text("Enter"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void TXT(t) {
    txt = t;
  }

  void initState() {
    super.initState();
    Load_txt();
    print(user);
    FCM();

    if (messagelist.isEmpty) {
      messagelist.add(Hint());
    }
  }

  @override
  void dispose() {
    super.dispose();

    messagelist.clear();
  }

  void Load_txt() async {
    isar_LoadTxT() async {
      final isar = await openIsar();

      final user_txt = isar.user_txts;

      final allContacts = await user_txt.where().filter().partner_nameEqualTo(partner).findAll();

      return allContacts;
    }

    var txt_data = await isar_LoadTxT();

    print(txt_data);

    txt_data.forEach(
      (e) {
        if (e.format_isar == "MD") {
          if (e.user_name == user) {
            messagelist.add(MarkDown_Normal(
                markdown: e.user_chat_txt.toString().split("MD:")[1]));
          } else {
            messagelist.add(MarkDown_Normal_uke(
                markdown: e.user_chat_txt.toString().split("MD:")[1]));
          }
        } else if (e.format_isar == "TXT") {
          if (e.user_name == user) {
            messagelist.add(
              TitleChat(
                datas: e.user_chat_txt.toString(),
                time: e.time.toString(),
              ),
            );
          } else {
            messagelist.add(
              TitleChat_uke(
                datas: e.user_chat_txt.toString(),
                time: e.time.toString(),
              ),
            );
          }
        }
      },
    );

    if (this.mounted) {
      setState(() {});
    }
  }

  void PushTxt(txt) {
    if (txt != null) {
      if (txt.startsWith("md:") == true || txt.startsWith("MD:") == true) {
        String? format = "MD";

        if (txt.startsWith("md:") == true) {
          String? markdown = txt.split("md:")[1];

          setState(
            () {
              messagelist.add(
                MarkDown_Normal(
                  markdown: markdown,
                ),
              );
            },
          );
        } else if (txt.startsWith("MD:") == true) {
          String? markdown = txt.split("MD:")[1];

          setState(
            () {
              messagelist.add(
                MarkDown_Normal(
                  markdown: markdown,
                ),
              );
            },
          );
        }
        FCMpushAPI(user, format, txt);
        save_chat(user, format, txt);
      } else {
        String? format = "TXT";
        setState(
          () {
            messagelist.add(
              TitleChat(
                datas: txt,
                time: "${DateTime.now().hour}h ${DateTime.now().minute}m",
              ),
            );
          },
        );
        save_chat(user, format, txt);
        FCMpushAPI(user, format, txt);
      }
    }
  }

  void save_chat(user, format, txt) async {
    final now = DateTime.now();

    final isar = await openIsar();

    var data;

    data = user_txt()
      ..user_name = user
      ..partner_name = partner
      ..format_isar = format
      ..user_chat_txt = txt
      ..time = "${now.hour}h ${now.minute}m";

    await isar.writeTxn(
      (isar) async {
        await isar.user_txts.put(data); // insert
      },
    );
  }

  void FCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? format;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    token = await messaging.getToken(
      vapidKey:
          "BFrfO2CQfaaXTDdWsi8dTkJkEJoj5sT1lTeUJeW6vdURh5tWv1fpCAcYwxGqh98q-0j0JT7h1CxErteWQwoqxD4",
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }

        String? teke_data = message.data["chat"];
        format = message.data["format"];
        String? sending_name = message.data["user"];

        if (this.mounted) {
          if (teke_data?.startsWith("md:") == true) {
            String? markdown = teke_data?.split("md:")[1];
            format = "MD";
            if (sending_name != user) {
              setState(
                () {
                  messagelist.add(
                    MarkDown_Normal_uke(
                      markdown: markdown,
                    ),
                  );
                },
              );
            } else {
              setState(
                () {
                  messagelist.add(MarkDown_Normal_uke(
                    markdown: markdown,
                  ));
                },
              );
            }
          } else if (teke_data?.startsWith("MD:") == true) {
            String? markdown = teke_data?.split("MD:")[1];

            format = "MD";
            if (sending_name != user) {
              setState(
                () {
                  messagelist.add(MarkDown_Normal_uke(
                    markdown: markdown,
                  ));
                },
              );
            } else {
              setState(
                () {
                  messagelist.add(MarkDown_Normal_uke(
                    markdown: markdown,
                  ));
                },
              );
            }
          } else {
            format = "TXT";
            if (sending_name != user) {
              setState(
                () {
                  messagelist.add(
                    TitleChat_uke(
                      datas: teke_data!,
                      time: message.sentTime,
                    ),
                  );
                },
              );
            } else {
              setState(
                () {
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
          save_chat(sending_name, format, teke_data);
        }
      },
    );
  }

  void FCMpushAPI(user, format, txt) {
    if (Token == "note") {
    } else {
      Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      print("${user} $format $txt");

      String body = jsonEncode(
        {
          "to": "$token",
          "data": {
            "sender": "$user",
            "recipient" : [partner,uuid_hash],
            "chat": "$txt",
            "format": format,
          },
          "notification": {"body": "$txt"},
        },
      );

      String server_key =
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
  }
}
