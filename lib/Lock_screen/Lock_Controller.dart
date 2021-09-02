



import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';



class lock_controller {

  bool? backg;
  bool? getImageFromGallery_bool;


  lock_controller(this.backg, this.getImageFromGallery_bool);


  Return_lock_controller() async {

    //バックグラウンドロックの設定引き出し
    Future<bool?> return_back_task() async {
      var _temp_s;

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      _temp_s = prefs.getBool('back') ?? false;

      return _temp_s;
    }





    backg = (await return_back_task())!;

    print("getImageFromGallery_bool $getImageFromGallery_bool");
    print("backg $backg");



    if ((backg == true) && (getImageFromGallery_bool == true)){


      return true;

    }else if((backg == false) && ((getImageFromGallery_bool == false) || (getImageFromGallery_bool == null))){


      return false;

    }else{


      return true;

    }


  }



}