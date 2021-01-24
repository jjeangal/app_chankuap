
import 'package:app_chankuap/src/Widgets/drawer_header.dart';
import 'package:app_chankuap/src/app_bars/transaction_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Entrada.dart';
import 'Salida.dart';

class Transactions extends StatefulWidget {
  Transactions({Key key}) : super(key: key);

  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transactions> {
  String _title = "Transacciones";
  String name_entrada = "Entrada de Mercaderia";
  String name_salida = "Salida de Mercaderia";

  Widget _current = Entrada();

  final Entrada _entrada = Entrada();
  final Salida _salida = Salida();

  Widget _changeBody(int page) {
    switch (page) {
      case 0:
        return _entrada;
        break;
      case 1:
        return _salida;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: TransactionAppBar(_title),
            ),
            drawer: new Drawer(
              child: Container(
                color: Color(0xffEFEFEF),
                child: ListView(
                  children: <Widget>[
                    drawerHeader(),
                    ListTile(
                      title: Text(name_entrada),
                      onTap: () {
                        setState(() {
                          _current = _changeBody(0);
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    ListTile(
                      title: Text(name_salida),
                      onTap: () {
                        setState(() {
                          _current = _changeBody(1);
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ])
                ),
              ),
            body: _current));
  }
}
