import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ajent/Controller.dart';

Return_image_user? Imageset;


class UStting extends StatefulWidget {
  @override
  _usttings createState() => _usttings();
}

class _usttings extends State<UStting> {

  FileImage? _image_user;
  FileImage? _image_back;

  final picker = ImagePicker();


  Future getImageFromGallery_user() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image_user = FileImage(File(pickedFile!.path));
    });

    Imageset = Return_image_user(_image_user,_image_back);
  }


  Future getImageFromGallery_back() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image_back = FileImage(File(pickedFile!.path));
    });

    Imageset = Return_image_user(_image_user,_image_back);

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ユーザー設定"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(),
              onPressed: () {


              },
              child: Text(
                "ユーザー設定",
                style: TextStyle(fontSize: 30),
              ),
            ),
            FloatingActionButton(
              heroTag: "btn1",

              onPressed: getImageFromGallery_user, //ギャラリーから画像を取得
              tooltip: 'Pick Image From Gallery',
              child: Icon(Icons.photo_library),
            ),
            FloatingActionButton(
              heroTag: "btn2",

              onPressed: getImageFromGallery_back, //ギャラリーから画像を取得
              tooltip: 'Pick Image From Gallery',
              child: Icon(Icons.photo_library),
            ),
          ],
        ),
      ),
    );
  }
}
