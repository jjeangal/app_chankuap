import 'dart:convert';

import 'package:app_chankuap/src/Widgets/add_bar.dart';
import 'package:app_chankuap/src/Widgets/app_icons.dart';
import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:app_chankuap/src/buttons/transac_delete_button.dart';
import 'package:app_chankuap/src/forms/entradas/entrada_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Entrada extends StatefulWidget {
  Entrada({Key key}) : super(key: key);

  @override
  _EntradaState createState() => _EntradaState();
}

class _EntradaState extends State<Entrada> {

  List<EntradaOverview> entradas = [];
  EntradaOverview trans;

  void initState() {
    _getEntradas().then((value) => {
      setState(() {
        this.entradas = value;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Color(0xffEFEFEF),
        child: Column(
          children: <Widget>[
            AddBar(
                icon: Icon(AppIcons.entry, color: Color(0xff073B3A)),
                title: "Entrada de Mercaderia",
                page: 1),
            Expanded(
              child: ListView.builder(
                itemCount: entradas.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, index) =>
                  _buildListItem(context, index)),
            ),
          ],
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    return InkWell(
        child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(children: [
              Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: Text('Usuario', //${entradas[index].usario}
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              Align(
                  alignment: Alignment(-0.8, 0.5),
                  child: Text('${entradas[index].provider_id}',
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontStyle: FontStyle.italic,
                          fontSize: 16))),
              Align(
                  alignment: Alignment(0.65, 0),
                  child: Text('${entradas[index].fecha}',
                      style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))),
              Align(
                  alignment: Alignment(1.05, -1.4),
                  child: TransactionDeleteButton())
            ])),
        onTap: () async {
          await _getEntrada(entradas[index].trans_id).then((value) => {
            setState(() {
              this.trans = value;
            })
          });
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new EntradaForm(trans: trans)),
          );
        });
  }

  Future<EntradaOverview> _getEntrada(int id) async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/in/${id}';

    try {
      var uriResponse = await client.get(url + endpoint);
      print(endpoint);

      if (uriResponse.statusCode == 200) {
        Map<String, dynamic> body = json.decode(uriResponse.body);

        return EntradaOverview.fromJson(body);

      } else {
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }

  Future<List<EntradaOverview>>_getEntradas() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/in/';
    try {
      var uriResponse = await client.get(url+endpoint);
      //Future<http.Response> response = http.get(url+endpoint);

      List<EntradaOverview> entradas = [];

      if (uriResponse.statusCode == 200) {
        List<dynamic> body = jsonDecode(uriResponse.body);

        for (int i = 0; i < body.length; i++) {
          entradas.add(EntradaOverview.fromJson(body[i]));
        }
        return entradas;
      } else {
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
}
