import 'package:isar/isar.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'dart:io';

@Collection()
class fstPage_isar {
  int? id; // auto increment id

  List<String>? fstPage_setting;

  bool? setUP;

  bool? locled;

  bool? back;

  bool? passcode;

  bool? seitai;

  bool? auto;


}

@Collection()
class user_data_isar {
  int? id; // auto increment id

  String? user_name;

  int? number;

  String? uuid;

  List<String>? user_data;



}

@Collection()
class user_txt {
  int? id; // auto increment id

  String? user_name;

  String? format_isar;

  String? user_chat_txt;


}
