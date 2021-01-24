
import 'package:app_chankuap/src/app_bars/export_app_bar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../forms/entradas/entrada_form.dart';

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
  String tipo; // 1 -> entrada, 2 -> salida

  // Entrada or
  // Salida
  // + fecha range as values and data to put in http request

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
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ExportAppBar(_title),
        ),
        body: Container(
          color: Color(0xffEFEFEF),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: FormBuilderDateRangePicker(
                                decoration: const InputDecoration(
                                  labelText: 'Intial Fecha ',
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
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container()
                            ),
                            Expanded(
                              flex: 9,
                              child: FormBuilderDropdown(
                                onSaved: (value) => tipo = value,
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
                                    onPressed: () => _searchTransactions(),
                                  )
                              )
                            ),
                          ]
                        )
                      )
                    ],
                  )
                )
              ),
              Container(
                height: screenHeight(context) * 0.74,
                width: screenSize(context).width,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (context, index) =>
                        _buildListItem(context, index)),
              ),
              Container(
                height: screenHeight(context) * 0.1,
                width: screenSize(context).width,
                child: Align(
                    alignment: Alignment.center,
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
                              alignment: Alignment(-0.2, 0),
                              child: Text("Exportar",
                                  style: TextStyle(color: Color(0xff073B3A))),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.add, color: Color(0xff073B3A)),
                            )
                          ],
                        ),
                      ),
                    )
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
                  child: Text('Productor name',
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
                  alignment: Alignment(0.65, 0),
                  child: Text('10/11/2000',
                      style: TextStyle(
                        color: Color(0xff073B3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))),
            ])),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => entrada_form),
          );
        });
  }

  _searchTransactions() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      print("fetch all transaction in date range");
      print(fecha_una);
      print(fecha_dos);
      print(tipo);
      //create get request with fecha range + entrada/salida
      //show entradas/salidas
    }
  }

  _export() {
    print("here export data");
  }
}
