import 'dart:convert';

import 'package:app_chankuap/src/Widgets/CustomAlertDialog.dart';
import 'package:app_chankuap/src/Widgets/add_bar.dart';
import 'package:app_chankuap/src/Widgets/app_icons.dart';
import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:app_chankuap/src/forms/entradas/entrada_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

List<EntradaOverview> entradas = [];

class Entrada extends StatefulWidget {
  Entrada({Key key}) : super(key: key);

  @override
  _EntradaState createState() => _EntradaState();
}

class _EntradaState extends State<Entrada> {
  EntradaOverview trans;

  void initState() {
    _getEntradas().then((value) => {
      setState(() {
        entradas = value;
        entradas.sort((a, b) => (b.trans_id).compareTo(a.trans_id));
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
                  child: Text('${entradas[index].usario}', //${entradas[index].usario}
                        style: TextStyle(
                            color: Color(0xff073B3A),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                  )
              ),
              Align(
                  alignment: Alignment(-0.8, 0.5),
                  child: Text('Cedula', //${entradas[index].provider_id}
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontStyle: FontStyle.italic,
                          fontSize: 16))),
              Align(
                  alignment: Alignment(0.35, 0),
                  child: Text('${entradas[index].fecha}',
                      style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))),
              Align(
                alignment: Alignment(0.9, 0),
                child: Text('${entradas[index].trans_id}',
                    style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              Align(
                  alignment: Alignment(0.8, 0),
                  child:  IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.do_disturb_on_outlined),
                    color: Color(0xff9F4A54),
                    onPressed: () {
                      var dialog = CustomAlertDialog(
                        title: "Eliminar la transacción",
                        message: "Estas seguro?",
                        onPostivePressed: () {
                          _deleteEntrada(index);
                        },
                        positiveBtnText: 'Si',
                        negativeBtnText: 'No',
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog
                      );
                    }))
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

  _deleteEntrada(int index) async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/in/${entradas[index].trans_id}/';

    try {
      var uriResponse = await client.delete(url + endpoint);
      if (uriResponse.statusCode == 204) {
        setState((){
          entradas.removeAt(index);
        });
        Navigator.pop(context);
      } else {
        throw Exception('Failed to delete transaction');
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
