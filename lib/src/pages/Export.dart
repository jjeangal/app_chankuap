import 'dart:convert';

import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:app_chankuap/src/Widgets/TransactionType.dart';
import 'package:app_chankuap/src/app_bars/export_app_bar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../forms/entradas/entrada_form.dart';

List<TransactionType> trans = [];

class Export extends StatefulWidget {
  Export({Key key}) : super(key: key);

  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  String _title = "Export";

  final _formKey = GlobalKey<FormState>();
  final EntradaForm entrada_form = EntradaForm();

  String fecha_una;
  String fecha_dos;
  int tipo; // 1 -> entrada, 2 -> salida

  changeTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context) {
    return screenSize(context).height - 110;
  }

  @override
  void initState() {
    this.tipo = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ExportAppBar(_title),
        ),
        body: Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight(context)
          ),
          color: Color(0xffEFEFEF),
          child: Column(
            children: [
              Container(
                height: screenHeight(context) * 0.16,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: screenHeight(context) * 0.08,
                        ),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: FormBuilderDateRangePicker(
                                decoration: const InputDecoration(
                                  labelText: 'Fecha Rango',
                                ),
                                onSaved: (una) => {
                                  fecha_una = una[0].toString().substring(0, 10),
                                  fecha_dos = una[1].toString().substring(0, 10)
                                },
                                format: DateFormat('yy-MM-dd'),
                                attribute: 'date1',
                                firstDate: DateTime(2021, 1, 1),
                                lastDate:  DateTime(2060, 1, 01)
                              ),
                            ),
                          ],
                        )
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: screenHeight(context) * 0.08,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container()
                            ),
                            Expanded(
                              flex: 9,
                              child: FormBuilderDropdown(
                                onSaved: (value) => {
                                  if(value == 'Entrada') tipo = 1,
                                  if(value == 'Salida') tipo = 2,
                                },
                                initialValue: 'Entrada',
                                attribute: 'tipo',
                                items: [
                                  'Entrada',
                                  'Salida'
                                ].map((tipo) => DropdownMenuItem(
                                    value: tipo,
                                    child: Text("$tipo",
                                        textAlign: TextAlign.center)))
                                    .toList()),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  iconSize: 24,
                                  onPressed: () {
                                    _searchTransactions().then((value) => {
                                      setState(() {
                                        trans = value;
                                        trans.sort((a, b) => (b.trans_id).compareTo(a.trans_id));
                                      })
                                    });
                                  }
                                )
                              )
                            )
                          ]
                        )
                      )
                    ],
                  )
                )
              ),
              Container(
                height: screenHeight(context) * 0.68,
                width: screenSize(context).width,
                child: ListView.builder(
                    itemCount: trans.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (context, index) =>
                        _buildListItem(context, index)),
              ),
              Container(
                height: screenHeight(context) * 0.12,
                width: screenSize(context).width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: Color(0xff073B3A))
                        ),
                        onPressed: () => _export(),
                        splashColor: Colors.grey,
                        child: Container(
                          height: 50,
                          width: 120,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text("Exportar",
                                    style: TextStyle(color: Color(0xff073B3A))),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 3,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(color: Color(0xff073B3A))
                          ),
                          onPressed: () => print('imprimir'),
                          splashColor: Colors.grey,
                          child: Container(
                            height: 50,
                            width: 120,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Imprimir",
                                      style: TextStyle(color: Color(0xff073B3A))),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                  child: Text('${trans[index].username}',
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
              Align(
                  alignment: Alignment(-0.8, 0.5),
                  child: Text('Productor Code',
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontStyle: FontStyle.italic,
                          fontSize: 16))),
              Align(
                  alignment: Alignment(0.5, -0.5),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Text('${trans[index].date}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )))),
              Align(
                alignment: Alignment(0.5, 0.5),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: Text("${trans[index].trans_id}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Color(0xff073B3A),
                          fontSize: 16,
                      )
                  )
                )),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.print),
                    color: Color(0xff073B3A),
                    onPressed: () => print("print individual"),
                  ),
                ),
              )
            ])),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new EntradaForm(trans:
                new EntradaOverview(1, "2022-11-11", 2, 2))),
          );
        });
  }

  Future<List<TransactionType>>_searchTransactions() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      var client = http.Client();
      var url = 'https://wakerakka.herokuapp.com/';
      var endpoint = 'transactions/';

      try {
        String request;

        if (this.tipo == 1) request = ('$url$endpoint' + 'in/');
        if (this.tipo == 2) request = ('$url$endpoint' + 'out/');

        List<TransactionType> transac = [];

        String requestUrl = request + '?in_date=${this.fecha_una}&out_date=${this.fecha_dos}';
        print(requestUrl);
        var uriResponse = await client.get(requestUrl);

        if (uriResponse.statusCode == 200) {
          List<dynamic> body = jsonDecode(uriResponse.body);
          print(body.toString());

          for (int i = 0; i < body.length; i++) {
            if (tipo == 1) transac.add(EntradaOverview.fromJson(body[i]));
            if (tipo == 2) transac.add(SalidaOverview.fromJson(body[i]));
          }
          return transac;
        } else {
          throw Exception('Cannot receive response from server');
        }
      } finally {
        client.close();
      }
    }
  }

  _export() async {
    var client = http.Client();
    String url = 'https://wakerakka.herokuapp.com/';
    String endpoint = 'export/';
    try {
      String request;
      if (this.tipo == 1) request = ('$url$endpoint' + 'in');
      if (this.tipo == 2) request = ('$url$endpoint' + 'out');
      else print(this.tipo);

      String requestUrl = request + '?in_date=${this.fecha_una}&out_date=${this.fecha_dos}';
      var uriResponse = await client.get(requestUrl);

      if (uriResponse.statusCode == 200) {
        print("export worked");
      } else {
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
}
