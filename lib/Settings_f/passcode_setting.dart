import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajent/Controller.dart';


class PassCodeS extends StatefulWidget {



  @override
  _passcodes createState() => _passcodes();


}

class _passcodes extends State<PassCodeS> {




  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajent"),
      ),
      body: Center(
              child: Text("a"),
            ),
    );
  }
}
