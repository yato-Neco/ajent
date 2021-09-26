import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';

class MarkDown_Normal extends StatelessWidget {
  String? markdown;

  MarkDown_Normal({this.markdown});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (size.width / 1.1),
          ),
          child: ListTile(
            trailing: Icon(
              Icons.face,
              size: 37,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.blue.withOpacity(0.2),
            title: MarkdownBody(
              data: '$markdown',
              selectable: true,
              onTapLink: (a, i, u) async {
                await canLaunch(i.toString())
                    ? await launch(i.toString())
                    : throw 'Could not launch $i';
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MarkDown_Normal_uke extends StatelessWidget {
  String? markdown;

  MarkDown_Normal_uke({this.markdown});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (size.width / 1.1),
          ),
          child: ListTile(
            leading: Icon(
              Icons.face,
              size: 37,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.green.withOpacity(0.2),
            title: MarkdownBody(
              data: '$markdown',
              selectable: true,
              onTapLink: (a, i, u) async {
                await canLaunch(i.toString())
                    ? await launch(i.toString())
                    : throw 'Could not launch $i';
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Hint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
      margin: EdgeInsets.all(25),
      child: Text(
        "MarkDown(GFM) Hint 💡 \n [md: or MD:] \n [MD:# 見出し] [MD:- 箇条書き] [MD: 1. 番号付き] "
        "\n [MD: `code記法`] [MD: *強調*] [MD: **強調2**] "
        "\n [MD: ***強調3***] [MD: *** 水平線] [MD: ~~取り消し線~~] etc...",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black.withOpacity(0.5)),
      ),
    );
  }
}

class TitleChat extends StatelessWidget {
  String datas;
  var time;

  TitleChat({required this.datas, this.time});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (size.width / 1.1),
          ),
          child: ListTile(
            trailing: Icon(
              Icons.face,
              size: 37,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.blue.withOpacity(0.2),
            title: SelectableText(datas),
            subtitle: Text("${time} to you"),
          ),
        ),
      ],
    );
  }
}

class TitleChat_uke extends StatelessWidget {
  String datas;
  var time;

  TitleChat_uke({required this.datas, this.time});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (size.width / 1.1),
          ),
          child: ListTile(
            tileColor: Colors.green.withOpacity(0.2),
            title: Text(datas),
            subtitle: SelectableText("$time to you"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: Icon(
              Icons.face,
              size: 37,
            ),
          ),
        ),
      ],
    );
  }
}

class Stamp extends StatelessWidget {
  String datas;

  var image_data;

  Stamp({required this.datas, this.image_data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      tileColor: Colors.white.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Image.memory(image_data),
      subtitle: Text(datas),
      trailing: Icon(
        Icons.face,
        size: 37,
      ),
    );
  }
}

class Stamp_uke extends StatelessWidget {
  String datas;

  var image_data;

  Stamp_uke({required this.datas, this.image_data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      tileColor: Colors.white.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Image.memory(image_data),
      subtitle: Text(datas),
      leading: Icon(
        Icons.face,
        size: 37,
      ),
    );
  }
}

class beta_txt extends StatelessWidget {
  String datas;
  dynamic size = 0;

  beta_txt({required this.datas, required this.size});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: (size.width / 1.1),
            ),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(7.0),
                child: SelectableText(
                  "$datas",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ]);
  }
}
