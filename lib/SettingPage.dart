import 'package:ajent/Settings_f/User_Settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _screen_lock = false;
  String? platform;
  String? aircraft;
  Color themcolr = Colors.white;

  @override
  void initState() {
    super.initState();
    platform = Platform.operatingSystem;
    aircraft = Platform.localeName;

    WidgetsFlutterBinding.ensureInitialized();

    set_screenlock();
  }

  void set_screenlock() async {
    _screen_lock = (await return_screenlock())!;
    print(_screen_lock);
  }

  Future<bool?> return_screenlock() async {
    var _temp_s;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _temp_s = prefs.getBool('locked') ?? false;

    return _temp_s;
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
                    trailing: Icon(Icons.arrow_right),
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
                    trailing: Icon(Icons.arrow_right),
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
                            Navigator.of(context) //イースターエッグ
                                .pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                              return MyApp();
                            }));
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
