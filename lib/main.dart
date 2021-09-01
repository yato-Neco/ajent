import 'dart:async';

import 'package:ajent/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Other/1.dart';
import 'Settings_f/Security_Settings.dart';
import 'Settings_f/User_Settings.dart';
import 'Controller.dart';
import 'Lock_screen/lock_screen.dart';
import 'uppermenu/Upper1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

//バグ、右スワイプすると画面が固まる--修正完了

Return_FristPage? fstPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  fstPage = Return_FristPage(
      prefs.getBool('setUP') ?? false, prefs.getBool('locked') ?? false);

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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  late final String? user;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? _controller;

  String? user;

  Future<String?> userNameGet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    user = prefs.getString("user") ?? "なし";

    return user;
  }

  AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addObserver(this);

    zen();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state = $state');


    var test = lockScreen?.Return_lock_controller();

    print(test);

    //バックグラウンドロックの処理
    if ((state.toString() == "AppLifecycleState.inactive") &&
        await Ssett?.return_bool() == true) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LockScreen(true);
      }));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void zen() async {
    user = await userNameGet();

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
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
