import 'package:flutter/material.dart';

class TransactionAppBar extends StatelessWidget {
  String appBarTitle;

  TransactionAppBar(String title) {
    this.appBarTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$appBarTitle",
          style: TextStyle(fontSize: 19, color: Colors.white)),
      centerTitle: true,
      backgroundColor: Color(0xff073B3A),
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.search, color: Colors.white),
            onPressed: () => print("search"))
      ],
    );
  }
}
