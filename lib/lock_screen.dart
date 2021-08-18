import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class LockScreen extends StatefulWidget {
  @override
  _lockscreen createState() => _lockscreen();
}

class _lockscreen extends State<LockScreen> {
  int? haspeg;

  int? CwhRGm;

  GetPassHash() async {
    int? _temp;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    _temp = prefs.getInt('CwhRGm');

    return _temp;
  }

  void _SetPassHash() async {
    CwhRGm = await GetPassHash();

  }

  @override
  void initState() {
    _SetPassHash();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              enabled: true,
              autofocus: true,
              // 入力数
              maxLength: 15,
              style: TextStyle(color: Colors.black),
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
                haspeg = e.hashCode;

              },
            ),
            TextButton(
              style: ButtonStyle(),
              onPressed: () {
                if (CwhRGm == haspeg) {


                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MyHomePage(
                        title: 'Ajent',
                        user: null,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return ZoomPageTransitionsBuilder().buildTransitions(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                title: 'Ajent',
                                user: null,
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
              },
              child: Text(
                "LockScreen",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
