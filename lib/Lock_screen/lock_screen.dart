import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class LockScreen extends StatefulWidget {


  bool pop = false;

  LockScreen(bool p){
    pop = p;

  }

  @override
  _lockscreen createState() => _lockscreen(pop);
}

class _lockscreen extends State<LockScreen> {
  int? haspeg;

  int? CwhRGm;

  bool pop = false;

  _lockscreen(p){
    pop = p;
  }

  GetPassHash() async {
    int? _temp;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    _temp = prefs.getInt('CwhRGm');


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
                enabled: true,
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

                  print(digest);

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
                                user: null,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ZoomPageTransitionsBuilder()
                                    .buildTransitions(
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                      title: 'Ajent',
                                      user: null,
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

                    if(pop == true){
                      Navigator.pop(
                        context,);
                      print(pop);

                    }else if (pop == false){
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
