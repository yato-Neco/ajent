import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajent/Controller.dart';

Smart_lock? Ssett;

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
    _screen_lock = (await return_screenlock())!;

    _flag = await (Ssett?.return_bool() ?? false)!;

    if (mounted) {
      // initState内でsetStateを呼び出すに必要
      setState(() => _screen_lock = _screen_lock);
    }


  }

  Future<bool?> return_screenlock() async {
    var _temp_s;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _temp_s = prefs.getBool('locked') ?? false;

    return _temp_s;
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

                      _save();
                      print(a);

                      setState(() {
                        _screen_lock = a;
                      });

                      if (_screen_lock == false) {
                        setState(() {
                          _flag = false;
                        });
                        Ssett = Smart_lock(_flag);
                      }

                    },
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              title: Text("バックグラウンドロック"),
              onTap: () {
                if (_screen_lock == true) {
                  setState(() {
                    _flag = !_flag;
                  });
                  Ssett = Smart_lock(_flag);
                }else{
                  setState(() {
                    _flag = false;

                  });

                }

                print(_flag);
              },
              trailing: Checkbox(
                activeColor: Colors.blue,
                value: _flag,
                onChanged: (e) {
                  print(e);

                  if (_screen_lock == true) {
                    setState(() {
                      _flag = e!;
                    });
                    Ssett = Smart_lock(_flag);
                  } else {
                    _flag = false;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
