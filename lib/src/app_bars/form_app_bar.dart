import 'package:flutter/material.dart';

class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Agregar una transacción",
          style: TextStyle(fontSize: 19, color: Colors.white)),
      centerTitle: true,
      backgroundColor: Color(0xff073B3A),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
