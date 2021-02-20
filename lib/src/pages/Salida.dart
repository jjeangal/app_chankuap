import 'dart:convert';

import 'package:app_chankuap/src/Widgets/CustomAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../Widgets/add_bar.dart';
import '../Widgets/app_icons.dart';
import '../Widgets/data_object.dart';
import '../forms/salidas/salida_form.dart';

List<SalidaOverview> salidas = [];

class Salida extends StatefulWidget {
  @override
  _Salida createState() => _Salida();
}

class _Salida extends State<Salida> {
  SalidaOverview trans;

  @override
  void initState() {
    _getSalidas().then((result) {
        setState(() {
          salidas = result;
          salidas.sort((a, b) => (b.trans_id).compareTo(a.trans_id));
        });
      }
    );
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
                title: "Salida de Mercaderia",
                page: 2),
            Expanded(
              child: ListView.builder(
                  itemCount: salidas.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (context, index) =>
                      _buildListItem(context, index)
              ),
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
              alignment: Alignment(-0.8, 0),
              child: Container(
                  child: Text('${salidas[index].cliente}',
                      style:
                          TextStyle(color: Color(0xff073B3A), fontSize: 18))),
            ),
            Align(
              alignment: Alignment(0.35, 0),
              child: Text('${salidas[index].date}',
                  style: TextStyle(
                    color: Color(0xff073B3A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ))),
            Align(
              alignment: Alignment(0.9, 0),
              child: Text('${salidas[index].trans_id}',
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
                          _deleteSalida(index);
                        },
                        positiveBtnText: 'Si',
                        negativeBtnText: 'No',
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog
                      );
                    }))
            ])
        ),
        onTap: () async {
          await _getSalida(salidas[index].getId()).then((result) {
            setState(() {
              this.trans = result;
            });
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new SalidaForm(trans: trans)),
          );
          setState(() {});
        });
  }

  Future<SalidaOverview> _getSalida(int id) async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/${id}';

    try {
      var uriResponse = await client.get(url + endpoint);
      print(endpoint);

      if (uriResponse.statusCode == 200) {
        Map<String, dynamic> body = json.decode(uriResponse.body);

        return SalidaOverview.fromJson(body);
      } else {
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }

  _deleteSalida(int index) async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/${salidas[index].trans_id}/';

    try {
      var uriResponse = await client.delete(url + endpoint);
      if (uriResponse.statusCode == 204) {
        setState((){
          salidas.removeAt(index);
        });
        Navigator.pop(context);
      } else {
        throw Exception('Failed to delete transaction');
      }
    } finally {
      client.close();
    }
  }

  Future<List<SalidaOverview>> _getSalidas() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/';
    try {
      var uriResponse = await client.get(url+endpoint);
      //Future<http.Response> response = http.get(url+endpoint);
      List<SalidaOverview> salidas = [];

      if (uriResponse.statusCode == 200) {
        List<dynamic> body = jsonDecode(uriResponse.body);

        for (int i = 0; i < body.length; i++) {
          salidas.add(SalidaOverview.fromJson(body[i]));
        }

        return salidas;

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
}
