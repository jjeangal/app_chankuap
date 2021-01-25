import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../Widgets/add_bar.dart';
import '../Widgets/app_icons.dart';
import '../buttons/transac_delete_button.dart';
import '../Widgets/data_object.dart';
import '../forms/salidas/salida_form.dart';

class Salida extends StatefulWidget {
  @override
  _Salida createState() => _Salida();
}


class _Salida extends State<Salida> {

  final List<SalidaOverview> salidas = [];

  final SalidaForm salida_form = SalidaForm();

  @override
  void initState() {
    _getSalidas();
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
                alignment: Alignment(0.65, 0),
                child: Text('${salidas[index].fecha}',
                    style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            Align(
                alignment: Alignment(1.05, -1.4),
                child: TransactionDeleteButton())
          ]),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => salida_form),
          );
        });
  }

  _getSalidas() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/';
    try {
      var uriResponse = await client.get(url+endpoint);
      //Future<http.Response> response = http.get(url+endpoint);

      _buildSalidas();

      if (uriResponse.statusCode == 200) {
        List<dynamic> body = jsonDecode(uriResponse.body);

        for (int i = 0; i < body.length; i++) {
          this.salidas.add(SalidaOverview.fromJson(body[i]));
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }

      print(await uriResponse);

    } finally {
      client.close();
    }
  }



  _buildSalidas() {

  }
}
