import 'dart:core';

import '../isar.g.dart';

class lock_controller {
  bool? backg;
  bool? getImageFromGallery_bool;

  lock_controller(this.backg, this.getImageFromGallery_bool);

  Return_lock_controller() async {
    //バックグラウンドロックの設定引き出し

    FristPage_Settingback() async {
      final isar = await openIsar();

      final fstPage_isars = isar.fstPage_isars;

      var setting = await fstPage_isars.get(0);

      return setting?.back;
    }

    backg = await FristPage_Settingback() ?? false;

    print("getImageFromGallery_bool $getImageFromGallery_bool");
    print("backg $backg");

    if ((backg == true) && (getImageFromGallery_bool == true)) {
      print(false);
      return false;
    } else if ((backg == true) && ((getImageFromGallery_bool == false))) {
      print(true);
      return true;
    } else if ((backg == false) && ((getImageFromGallery_bool == false))) {
      print(false);
      return false;
    } else if ((backg == false) && ((getImageFromGallery_bool == true))) {
      print(false);
      return false;
    } else {
      print(true);
      return false;
    }
  }
}
