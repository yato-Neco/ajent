import 'package:ajent/Chat/Chat_page.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';
import '../isar.g.dart';
import '../databace_isar.dart';


class Up1 extends StatefulWidget {
  @override
  _up1 createState() => _up1();
}

class _up1 extends State<Up1> {
  var text;

  List<Model>? modelList;




  String? user;





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

  @override
  void initState() {
    super.initState();
    Usar_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("demo"),
              tileColor: Colors.red,
              onTap: ()async {





                  final isar = await openIsar();

                  final test = isar.user_data_isars;

                  var user_data = await test.get(0);




                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                {
                  return Chat_page(user: user,partner: "demo",Token: null,uuid_hash: "${user_data?.uuid}${user_data?.id}",);
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("メモ"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                {
                  return Chat_page(user: user,partner: "メモ",Token: "note",uuid_hash: null,);
                }));

              },
            ),
          ),
        ],
      ),
    );
  }
}

class Model {
  final String title;
  final String subTitle;
  final String key;

  Model({
    required this.title,
    required this.subTitle,
    required this.key,
  });
}
