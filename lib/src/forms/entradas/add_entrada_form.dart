import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:app_chankuap/src/Widgets/selectMaterial.dart';
import 'package:app_chankuap/src/app_bars/form_app_bar.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../product_list_form.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddEntradaForm extends StatefulWidget{

  @override
  _AddEntradaFormState createState() => _AddEntradaFormState();
}

class _AddEntradaFormState extends State<AddEntradaForm> {
  final _formKey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _productorName = "";
  String _codigoProductor = "";
  String _cedula = "";
  String _comunidad = "";
  String _transporte = "Carro";

  List<Producto> productos = [];

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final DondeFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();

  @override
  void initState() {
    super.initState();
    stepperPage.productos = productos;
    productList.productos = productos;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: FormAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height - 110,
        child: SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        "Entrada De Mercaderia - Ficha n°" +
                          "2(fixo)", //request numero latest ficha
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    InputDatePickerFormField(
                        onDateSaved: (value) => {
                          _fechaUno = DateFormat(
                              'yyyy-MM-dd').format(value).toString()
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021, 1, 1),
                        lastDate:  DateTime(2060, 1, 1)
                    ),
                    SizedBox(height: 10),
                    InputDatePickerFormField(
                        onDateSaved: (value) => {
                          _fechaDos = DateFormat(
                              'yyyy-MM-dd').format(value).toString()
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021, 1, 1),
                        lastDate:  DateTime(2060, 1, 1)
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                      onSaved: (value) => _usario = value,
                        decoration: const InputDecoration(labelText: 'Quien'),
                        initialValue: _usario,
                        attribute: 'quien',
                        items: [
                          'Isaac',
                          'Yollanda',
                          'Nube',
                          'Veronica',
                          'Anita'
                        ].map((quien) => DropdownMenuItem(
                                value: quien,
                                child: Text("$quien",
                                    textAlign: TextAlign.center)))
                            .toList()),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Productor',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (name) {
                        _productorName = name;
                      },
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Necesitas el nombre del productor';
                        }
                        return null;
                      },
                      autofocus: true,
                      focusNode: clienteFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(clienteFocusNode);
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Codigo de Producto',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (codigo) {
                        _codigoProductor = codigo;
                      },
                      validator: (codigo) {
                        if (codigo.isEmpty) {
                          return 'Necesitas un codigo';
                        }
                        return null;
                      },
                      autofocus: true,
                      focusNode: CodigoFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(CodigoFocusNode);
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Cedula',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (id) {
                        _cedula = id;
                      },
                      validator: (id) {
                        if (id.isEmpty) {
                          return 'Necesitas un cedula';
                        }
                        return null;
                      },
                      autofocus: true,
                      focusNode: IdFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(IdFocusNode);
                      },
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                        decoration: const InputDecoration(labelText: 'Comunidad'),
                        initialValue: "Shuar",
                        attribute: 'comunidad',
                        onSaved: (value) => {
                          _comunidad = value,
                        },
                        items: [
                          'Shuar',
                          'Achuar'
                        ].map((comu) => DropdownMenuItem(
                            value: comu,
                            child: Text("$comu",
                                textAlign: TextAlign.left)
                        )).toList()),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                      initialValue: _transporte,
                      onSaved: (value) => _transporte = value,
                        attribute: 'medio',
                        decoration: const InputDecoration(
                          labelText: 'Medio de Transporte',
                        ),
                        items: ['Carro', 'Avion']
                            .map((medio) => DropdownMenuItem(
                                value: medio,
                                child: Text("$medio",
                                    textAlign: TextAlign.center)))
                            .toList()),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text("Materias Primas",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18)),
                        ),
                        Expanded(
                          flex: 2,
                          child: IconButton(
                              iconSize: 20,
                              icon: Icon(Icons.add),
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => stepperPage),
                                  )),
                        )
                      ],
                    ),
                    Container(
                        height: 300,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                            child: productList)),
                  ])))
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          confirmationDialog(context, "Estas seguro ?",
              title: "Confirmacion",
              confirmationText: "Click here to confirmar",
              positiveText: "Registrar", positiveAction: () {
                //empty values
                //push entrada
                _validateInputs();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      _sendEntrada();
    }
  }

  Future _sendEntrada() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/in/';

    EntradaTrans trans = new EntradaTrans(_fechaUno, _fechaDos, 1, _productorName,
        _codigoProductor, int.parse(_cedula), _comunidad, _transporte, productos);

    try {
      var uriResponse = await client.post(url+endpoint,
          body: json.encode(trans));
      print(json.encode(trans));

      if (await uriResponse.statusCode == 201) Navigator.pop(context);

      else print(await uriResponse.statusCode);
    } finally {
      client.close();
    }
  }
}
