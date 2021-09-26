import 'package:flutter/material.dart';


import 'package:isar/isar.dart';

import '../databace_isar.dart';
import '../isar.g.dart';

class SettingChat extends StatefulWidget {
  SettingChat({required this.token});

  final String token;

  @override
  _settingchat createState() => _settingchat(token: token);
}

class _settingchat extends State<SettingChat> {
  _settingchat({required this.token});

  String token;

  void Rest_chat() async {
    final isar = await openIsar();


    final user_txts = isar.user_txts;



    await isar.writeTxn((isar) async {
      final idsOfUnstarredContacts = await user_txts.where().idProperty().findAll();
      user_txts.deleteAll(idsOfUnstarredContacts.cast<int>());
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: Rest_chat, child: Text("Reset")),

            TextField(

            ),

            SelectableText(
              "$token",
            ),
          ],
        ),
      ),
    );
  }
}
