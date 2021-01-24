import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../Widgets/add_bar.dart';
import '../Widgets/app_icons.dart';
import '../buttons/transac_delete_button.dart';
import '../Widgets/data_object.dart';
import '../forms/salidas/salida_form.dart';

class Salida extends StatelessWidget {

  final List<SalidaOverview> salidas = [
    new SalidaOverview(1, 'Tienda Macas', '10-11-2000'),
    new SalidaOverview(2, 'Quito', '15-11-2000'),
  ];

  final SalidaForm salida_form = SalidaForm();

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
    var endpoint = '/transactions/in/';
    try {
      var uriResponse = await client.get(url+endpoint);

      _buildSalidas();

      print(await uriResponse);

    } finally {
      client.close();
    }
  }

  _buildSalidas() {

  }
}
