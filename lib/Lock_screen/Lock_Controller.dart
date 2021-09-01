



import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';



class lock_controller {

  bool? backg;
  bool? getImageFromGallery_bool;


  lock_controller(this.backg, this.getImageFromGallery_bool);


  Return_lock_controller() async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool backg = prefs.getBool('locked') ?? false;



    if ((backg == true) && (getImageFromGallery_bool == true)){


      return false;

    }else if((backg == true) && (getImageFromGallery_bool == false)){


      return true;

    }else{


      return true;

    }


  }



}