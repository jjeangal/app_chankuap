import 'package:flutter/material.dart';

class StepperAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Anadir producto",
          style: TextStyle(fontSize: 19, color: Color(0xff073B3A))),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff073B3A)),
    );
  }
}
