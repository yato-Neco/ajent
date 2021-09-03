import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajent/Controller.dart';

import '../databace_isar.dart';
import '../isar.g.dart';





class SStting extends StatefulWidget {
  @override
  _sstinfs createState() => _sstinfs();
}

class _sstinfs extends State<SStting> {
  bool _screen_lock = false;

  bool _flag = false;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    set_screenlock();
  }

  void set_screenlock() async {

    final isar = await openIsar();


    final fstPage_isars =  isar.fstPage_isars;

    var
    setting = await fstPage_isars.get(0);




    _screen_lock = (setting!.locled ?? false);

    _flag =  (setting.back ?? false);

    if (mounted) {
      // initState内でsetStateを呼び出すに必要
      setState(() => _screen_lock = _screen_lock);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajent"),
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
                    value: _screen_lock,
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.red,
                    inactiveThumbColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    secondary: new Icon(
                      Icons.lock,
                      color:
                          _screen_lock ? Colors.orange[700] : Colors.grey[500],
                      size: 50.0,
                    ),
                    title: Text("画面ロック"),
                    subtitle: Text(''),
                    onChanged: (a) {


                      _save() async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool("locked", a);
                      }


                      isar_save() async {
                        final isar = await openIsar();

                        var setting;

                        setting = fstPage_isar()
                          ..setUP = true
                          ..locled = a
                          ..id = 0
                        ;


                        await isar.writeTxn((isar) async {
                          await isar.fstPage_isars.put(setting); // insert
                        });
                      }

                      isar_save();

                      setState(
                        () {
                          _screen_lock = a;
                        },
                      );

                      if (_screen_lock == false) {
                        setState(
                          () {
                            _flag = false;
                          },
                        );



                        isar_save() async {

                          final isar = await openIsar();

                          var setting;

                          setting = fstPage_isar()
                            ..setUP = true
                            ..back = false
                            ..id = 0
                          ;


                          await isar.writeTxn((isar) async {
                            await isar.fstPage_isars.put(setting); // insert
                          });
                        }

                        isar_save();



                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
              bottom: 5,
            ),
            child: ListTile(
              title: Text("バックグラウンドロック"),
              onTap: () {
                if (_screen_lock == true) {
                  setState(
                    () {
                      _flag = !_flag;
                    },
                  );
                  isar_save() async {

                    final isar = await openIsar();

                    var setting;

                    setting = fstPage_isar()
                      ..setUP = true
                      ..back = _flag
                      ..id = 0
                    ;


                    await isar.writeTxn((isar) async {
                      await isar.fstPage_isars.put(setting); // insert
                    });
                  }

                  isar_save();
                } else {
                  setState(
                    () {
                      _flag = false;
                    },
                  );
                }
              },
              trailing: Checkbox(
                activeColor: Colors.blue,
                value: _flag,
                onChanged: (e) {
                  if (_screen_lock == true) {
                    setState(
                      () {
                        _flag = e!;
                      },
                    );

                    isar_save() async {

                      final isar = await openIsar();

                      var setting;

                      setting = fstPage_isar()
                        ..setUP = true
                        ..locled = true
                        ..back = e
                        ..id = 0
                      ;


                      await isar.writeTxn((isar) async {
                        await isar.fstPage_isars.put(setting); // insert
                      });
                    }

                    isar_save();

                  } else {
                    _flag = false;



                  }
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
              bottom: 5,
            ),
            child: ListTile(
              title: Text("パスコード"),
              onTap: () {
                if (_screen_lock == true) {
                  setState(
                        () {
                      _flag = !_flag;
                    },
                  );
                } else {
                  setState(
                        () {
                      _flag = false;
                    },
                  );
                }
              },
              trailing: Checkbox(
                activeColor: Colors.blue,
                value: _flag,
                onChanged: (e) {
                  if (_screen_lock == true) {
                    setState(
                          () {
                        _flag = e!;
                      },
                    );
                  } else {
                    _flag = false;
                  }
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
              bottom: 5,
            ),
            child: ListTile(
              title: Text("生体認証"),
              onTap: () {},
              trailing: Checkbox(
                activeColor: Colors.blue,
                value: false,
                onChanged: (e) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
