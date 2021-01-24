
import 'package:app_chankuap/src/buttons/add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBar extends StatefulWidget {
  final Icon icon;
  final String title;
  final int page;

  AddBar({Key key, this.icon, this.title, this.page}) : super(key: key);

  _AddBarState createState() => new _AddBarState();
}

class _AddBarState extends State<AddBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: widget.icon,
          ),
          Expanded(
            flex: 5,
            child: Text(widget.title,
                style: TextStyle(color: Color(0xff073B3A), fontSize: 16)),
          ),
          Expanded(flex: 3, child: new AddButton(page: widget.page))
        ]));
  }
}
