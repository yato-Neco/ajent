import 'package:ajent/Lock_screen/Lock_Controller.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ajent/Controller.dart';


Return_image_user? Imageset;
lock_controller? lockScreen;


class UStting extends StatefulWidget {
  @override
  _usttings createState() => _usttings();
}

class _usttings extends State<UStting> {
  FileImage? _image_user;
  FileImage? _image_back;


  final picker = ImagePicker();

  Future getImageFromGallery_user() async {


    lockScreen = lock_controller(null,true);



    final pickedFile = await picker.pickImage(source: ImageSource.gallery);



    setState(() {
      // Unhandled Exception: Null check operator used on a null value がでる部分
      _image_user = FileImage(File(pickedFile!.path));
    });

    Imageset = Return_image_user(_image_user, _image_back);
  }

  Future getImageFromGallery_back() async {


    lockScreen = lock_controller(null,true);


    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image_back = FileImage(File(pickedFile!.path));
    });

    Imageset = Return_image_user(_image_user, _image_back);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ユーザー設定"),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 15,
              bottom: 15,
            ),
            child: ListTile(
              leading: FloatingActionButton(
                heroTag: "btn1",

                onPressed: getImageFromGallery_user, //ギャラリーから画像を取得
                tooltip: 'Pick Image From Gallery',
                child: Icon(Icons.photo_library),
              ),
              title: Text("ユーザーアイコン"),
              onTap: getImageFromGallery_user,
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 15,
              bottom: 15,
            ),

            child: ListTile(
              leading: FloatingActionButton(

                heroTag: "btn2",

                onPressed: getImageFromGallery_back, //ギャラリーから画像を取得
                tooltip: 'Pick Image From Gallery',
                child: Icon(Icons.photo_library),
              ),
              title: Text("バックギャラリー"),
              onTap: getImageFromGallery_back,
            ),
          ),
        ],
      ),
    );
  }
}
