import 'package:flutter/material.dart';

class ExportAppBar extends StatelessWidget {
  String appBarTitle;

  ExportAppBar(String title) {
    this.appBarTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$appBarTitle"),
      centerTitle: true,
      backgroundColor: Color(0xff073B3A),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.search), onPressed: () => print("search"))
      ],
    );
  }
}
