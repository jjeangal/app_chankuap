import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xff073B3A),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Tipos de Transacciónes',
          style: TextStyle(
            color: Color(0xffEFEFEF),
            fontSize: 24,
          ),
        ),
      )
    );
  }
}
