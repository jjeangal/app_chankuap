import 'package:flutter/material.dart';

class ProcessesAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Processes",
          style: TextStyle(fontSize: 19, color: Color(0xff073B3A))),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff073B3A)),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.search, color: Color(0xff073B3A)),
            onPressed: () => print("search"))
      ],
    );
  }
}
