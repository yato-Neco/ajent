import 'package:ajent/Settings_f/User_Settings.dart';
import 'package:flutter/material.dart';
import 'Settings_f/Security_Settings.dart';
import 'main.dart';
import 'package:provider/provider.dart';

import 'dart:io';

class Setting extends StatefulWidget {
  @override
  Settings createState() => Settings();
}

class Settings extends State<Setting> {
  //隠し要素に使う
  int i = 0;

  bool _active = true;
  String? platform;
  String? aircraft;
  Color themcolr = Colors.white;

  @override
  void initState() {
    super.initState();
    platform = Platform.operatingSystem;
    aircraft = Platform.localeName;

    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - padding.top - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height - padding.top - padding.bottom - 22;
    }

/*
SimpleDialog(
            title: Text(''),
            backgroundColor: Colors.transparent.withOpacity(0.0),

            children: <Widget>[




/*
              SimpleDialogOption(

                child: ListTile(
                  title: Text('イースターエッグ'),

                ),
                onPressed: () {

                },
              ),
              SimpleDialogOption(
                child: ListTile(
                  title: Text('back'),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    "back",
                  );
                },
              ),


 */
            ],
          );
 */

    Future _showSimpleDialog() async {
      String? result = "";
      result = await showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: GestureDetector(
              onLongPressStart: (a){
                print(a);

              },
              onLongPressEnd: (a){
                print(a);
                Navigator.pop(
                  context,
                  "back",
                );
          }
            ),

          );
        },
      );
    }

    /*
      Future _showSimpleDialog() async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select account'),
          children: <Widget>[
            SimpleDialogOption(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade200,
                  child: Text(
                    'U1',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                title: Text('user1@keicode.com'),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  "user1",
                );
              },
            ),
            SimpleDialogOption(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  child: Text(
                    'U2',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                title: Text('user2@gmail.com'),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  "user2",
                );
              },
            ),
            SimpleDialogOption(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade700,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                title: Text('Add account'),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  "Add account",
                );
              },
            ),
          ],
        );
      },
    );
    _setLabel(result);
  }
     */

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            locale: Locale("ja", "JP"),
          ),
        ),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
                bottom: Radius.circular(25),
              ),
            ),
            child: ListBody(
              children: [
                Card(
                  margin: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                      bottom: Radius.circular(25),
                    ),
                  ),
                  child: new SwitchListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                        bottom: Radius.circular(25),
                      ),
                    ),
                    value: _active,
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.red,
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    secondary: new Icon(
                      Icons.dark_mode,
                      color: _active ? Colors.orange[700] : Colors.grey[500],
                      size: 50.0,
                    ),
                    title: Text('DarkMode'),
                    subtitle: Text(''),
                    onChanged: (a) {},
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                      bottom: Radius.circular(25),
                    ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                        bottom: Radius.circular(25),
                      ),
                    ),
                    title: Text("ユーザー設定"),
                    subtitle: Text(""),
                    leading: Icon(
                      Icons.face,
                      size: 50.0,
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UStting();
                      }));
                    },
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                      bottom: Radius.circular(25),
                    ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                        bottom: Radius.circular(25),
                      ),
                    ),
                    title: Text("セキュリティ"),
                    subtitle: Text(""),
                    leading: Icon(
                      Icons.lock,
                      size: 50.0,
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SStting();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ),
          ListBody(
            children: [
              Card(
                margin: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                    bottom: Radius.circular(25),
                  ),
                ),
                child: ListBody(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: ListTile(
                        title: Text("OS" + " " * 50 + "$platform"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text.rich(
                          TextSpan(
                            text: '言語', // default text style
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ' * 50,
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: '$aircraft',
                                style: TextStyle(
                                    //color: themcolr.withOpacity(1.0),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          i++;
                          print(i);
                          if (i == 5) {
                            i = 0;

                            //_showMyDialog();
                            _showSimpleDialog();

                            /*

                            Navigator.of(context) //イースターエッグ
                                .pop();

                             */
                          } else if (i > 5) {
                            i = 0;
                          } else {}
                        },
                        child: ListTile(
                          title: Text.rich(
                            TextSpan(
                              text: "バージョン",
                              children: [
                                TextSpan(text: ' ' * 37, style: TextStyle()),
                                TextSpan(text: "0.01a"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
