import 'package:flutter/cupertino.dart';

import 'Account/Account_create.dart';
import 'Settings_f/User_Settings.dart';
import 'isar.g.dart';
import 'main.dart';
import 'Lock_screen/lock_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:shared_preferences/shared_preferences.dart';



class Return_FristPage  {
  bool? setUP;
  bool? locled;

  List<String>? fstPage_isarsList;





  Return_FristPage(this.setUP,this.locled,this.fstPage_isarsList);
  PageReturn() {

    print("locled $locled");




    if(setUP == false){
      return Acreate();
    }else if(setUP == true && locled == false){
      //作り直し
      return MyHomePage(title: "Ajent", user: "None");
    }else if(setUP == true && locled == true){
      return LockScreen(false);
    }
    else{
      return Acreate();
    }
  }
}

class Return_image_user{
  FileImage? _image_user;
  FileImage? _image_back;

  Return_image_user(this._image_user,this._image_back);

  image_user(){
    return _image_user!;
  }

  image_back(){



      return _image_back;

  }

}

class Smart_lock{
  bool back_task;

  Smart_lock(this.back_task){

    _save() async {
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      await prefs.setBool("back", back_task);
    }
    _save();
  }






  return_bool() async {

    Future<bool?> return_back_task() async {
      var _temp_s;

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      _temp_s = prefs.getBool('back') ?? false;

      return _temp_s;
    }


    return await return_back_task() ?? false;

  }

}

class FriendListClass{
  int FrinedInt = 0;

  var FriendList;

  FriendListClass(this.FriendList);

  int ReturnFrinedInt(){

    return FrinedInt;

  }

  ReturnFrinedWiget(){


  }

}