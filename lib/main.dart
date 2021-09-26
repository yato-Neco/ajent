import 'dart:async';
import 'dart:ffi';

import 'package:ajent/Chat/Chat_page.dart';
import 'package:ajent/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Lock_screen/Lock_Controller.dart';
import 'Other/1.dart';
import 'Chat/Chat_demo.dart';
import 'Settings_f/Security_Settings.dart';
import 'Settings_f/User_Settings.dart';
import 'Controller.dart';
import 'Lock_screen/lock_screen.dart';
import 'isar.g.dart';
import 'uppermenu/Upper1.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

//バグ、右スワイプすると画面が固まる--修正完了

Return_FristPage? fstPage;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();





  final isar = await openIsar();

  FristPage_SettingList() async {
    final fstPage_isars = isar.fstPage_isars;

    var setting = await fstPage_isars.get(0);

    return setting?.fstPage_setting;
  }

  FristPage_SettingsetUP() async {
    final fstPage_isars = isar.fstPage_isars;

    var setting = await fstPage_isars.get(0);

    return setting?.setUP;
  }

  FristPage_Settinglocked() async {
    final fstPage_isars = isar.fstPage_isars;

    var setting = await fstPage_isars.get(0);

    return setting?.locled;
  }

  print("setUP ${await FristPage_SettingsetUP() ?? false}");

  fstPage = Return_FristPage(await FristPage_SettingsetUP() ?? false,
      await FristPage_Settinglocked() ?? false, await FristPage_SettingList());

  runApp(MyApp());
}

enum Answers { OK, CLOSE } //Quick Addのボタン enumについては知らん

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ajent',
        theme: ThemeData(
          brightness: Brightness.dark,

          //フォントのライセンス確認

          fontFamily: 'NotoSansJP',

          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              //CupertinoPageTransitionsBuilder()はiosを追加しないと正しく動作しない↓f
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
              TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
              TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: fstPage?.PageReturn());
  }
}

class TabPage extends StatefulWidget {
  @override
  _Tabpage createState() => _Tabpage();
}

class _Tabpage extends State<TabPage> {
  List<Widget> friend_list = [];

  String? user;

  @override
  void initState() {
    super.initState();
    Usar_data();
  }


  void Usar_data() async {
    Map<String, String?>? demoMap = {
      "user": null,
      "number": null,
      "uuid": null
    };

    user_dataDEMO() async {
      final isar = await openIsar();

      final test = isar.user_data_isars;

      var user_data = await test.get(0);

      return user_data?.user_data;
    }

    List<String>? userData = await user_dataDEMO();

    userData?.forEach((e) {
      List<String> has = e.split(": ");

      demoMap[has[0]] = has[1];
    });

    user = demoMap["user"];

    if (mounted) {
      // initState内でsetStateを呼び出すに必要
      setState(() => user = user);
    }
  }


  List<Widget> Friend_void() {
    friend_list = [
      Card(
        margin: EdgeInsets.only(right: 35),
        child: TextField(
          maxLines: 1,
          minLines: 1,
          decoration: const InputDecoration(
              icon: Icon(Icons.search), labelText: "フレンド検索"),
          onChanged: (e) {
            print("$e");
          },
        ),
      ),
    ];

    return friend_list;
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                {
                  return Chat_page(user: user,partner: "loacl",);
                }));
              },
              child: Text("C"),
            ),
            TextButton(
              onPressed: () {
                friend_list.add(
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.face),
                      title: Text('User$i'),
                      trailing: friend_menu(),
                      onTap: () {
                        print(i);
                      },
                    ),
                  ),
                );

                i++;
              },
              child: Text("ADD"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title})
      : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? _controller;

  String? user;

  bool? sc = false;

  bool? test = true;


  AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addObserver(this);

    zen();

    lock_controller(null, false, false);

    comeback = false;
    sc = false;

    print("main.dart");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state = $state');


    //print("await lockScreen?.Return_lock_controller() ${ await lockScreen?.Return_lock_controller()}");


    FristPage_Settingback() async {
      final isar = await openIsar();

      final fstPage_isars = isar.fstPage_isars;

      var setting = await fstPage_isars.get(0);

      return setting?.back;
    }


    print("comebac ${comeback}");


    if (sc == true && comeback == true) {
      test = true;
    } else if (sc == false && comeback == false) {
      test = true;
    } else if (sc == false && comeback == true) {
      test = false;
    }
    else {
      test = false;
    }


    //バックグラウンドロックの処理
    if (state.toString() == "AppLifecycleState.paused" &&
        await lockScreen?.Return_lock_controller() == true && test == true) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LockScreen(true),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ZoomPageTransitionsBuilder().buildTransitions(
              MaterialPageRoute(builder: (context) => LockScreen(true)),
              context,
              animation,
              secondaryAnimation,
              child,
            );
          },
        ),
      ).then((value) {
        print("value ${value}");
        sc = value;
        comeback = false;
      });
    }

    /*
    if (state.toString() == "AppLifecycleState.resumed") {
      lockScreen = lock_controller(null, lockScreen?.getImageFromGallery_bool , false);


    }



    if (state.toString() == "AppLifecycleState.inactive") {
      lockScreen = lock_controller(null, lockScreen?.getImageFromGallery_bool ,false);




    }




     */


    if (state.toString() == "AppLifecycleState.resumed") {
      lockScreen =
          lock_controller(null, false, false);


      print("0");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void zen() async {
    Map<String, String?>? demoMap = {
      "user": null,
      "number": null,
      "uuid": null
    };

    user_dataDEMO() async {
      final isar = await openIsar();

      final test = isar.user_data_isars;

      var user_data = await test.get(0);

      return user_data?.user_data;
    }

    print("user_dataDEMO ${await user_dataDEMO()}");

    List<String>? userData = await user_dataDEMO();

    userData?.forEach((e) {
      List<String> has = e.split(": ");

      demoMap[has[0]] = has[1];
    });

    print(demoMap);

    user = demoMap["user"];

    if (mounted) {
      // initState内でsetStateを呼び出すに必要
      setState(() => user = user);
    }
  }

  void _Settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Setting();
    }));
  }

  String _value = '';

  void _setValue(String value) => setState(() => _value = value);

  void _CreateChatRoom(int index) async {
    print(index);
    if (index == 2) {
      print("CreateChatRoom!");
    } else if (index == 1) {
      var value = await showModalBottomSheet<Answers>(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return new Container(
            height: 260,
            margin: EdgeInsets.all(0.0),
            padding: new EdgeInsets.all(0.0),
            child: new Column(
              children: <Widget>[
                new Text('Demo'),
                new Text('Friend Add'),
                new Text(''),
                new ElevatedButton(
                  onPressed: () => Navigator.pop(context, Answers.OK),
                  child: new Text('OK'),
                ),
                new ElevatedButton(
                  onPressed: () => Navigator.pop(context, Answers.CLOSE),
                  child: new Text('Close'),
                ),
              ],
            ),
          );
        },
      );
      switch (value!) {
        case Answers.OK:
          _setValue('OK');
          print("OK");
          break;
        case Answers.CLOSE:
          _setValue('CLOSE');
          print("CLOSE");
          break;
      }
    }
  }

  List<Widget> _buildTabs(BuildContext context) {
    return [

      Tab(text: 'Home'),
      Tab(text: 'Chat'),

    ];
  }

  List<Widget> _buildTabPages() {
    return [

      TabPage(),
      Up1(),
    ];
  }

  List<Widget> friend_list = [];

  List<Widget> Friend_void() {
    friend_list = [
      Card(
        margin: EdgeInsets.only(right: 35),
        child: TextField(
          maxLines: 1,
          minLines: 1,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              icon: Icon(Icons.search), labelText: "フレンド検索"),
          onChanged: (e) {
            print("$e");
          },
        ),
      ),
    ];

    return friend_list;
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          bottom: TabBar(
            controller: _controller,
            tabs: _buildTabs(context),
          ),
          title: Text(widget.title),
          actions: [
            IconButton(
              tooltip: "You can change the settings of the app",
              icon: Icon(Icons.settings),
              onPressed: _Settings,
            ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: user_menu("$user"),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: Imageset?.image_back() == null
                          ? null
                          : DecorationImage(image: Imageset?.image_back()),
                    ),
                  ),
                  ExpansionTile(
                    title: ListTile(
                      title: Text("フレンド"),
                    ),
                    children: Friend_void(),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          controller: _controller,
          children: _buildTabPages(),
        ),
        /*
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  bool? setUP = false;

                  _save() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool("setUP", setUP);
                  }

                  _save();
                },
                child: Text("C"),
              ),
              TextButton(
                onPressed: () {
                  friend_list.add(
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.face),
                        title: Text('User$i'),
                        trailing: friend_menu(),
                        onTap: () {
                          print(i);
                        },
                      ),
                    ),
                  );

                  i++;
                },
                child: Text("ADD"),
              ),
            ],
          ),
        ),*/
        bottomNavigationBar: BottomNavigationBar(
          onTap: _CreateChatRoom,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Quick Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class friend_menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "1",
          //アイコンに変えとく
          child: Text(
            'お気に入り',
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: "2",
          child: Text('ミュート'),
        ),
        const PopupMenuItem<String>(
          value: "3",
          child: Text(
            'ブロック',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class user_menu extends StatelessWidget {
  String? user;

  user_menu(String? u) {
    user = u;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: [
        Row(
          children: [
            Imageset?.image_user() == null
                ? Icon(
              Icons.face,
              size: 50,
            )
                : Image(
              image: Imageset?.image_user(),
              width: 50,
              height: 50,
            ),
            Text(
              "$user",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
