import 'package:app_chankuap/src/Widgets/selectMaterial.dart';
import 'package:app_chankuap/src/app_bars/form_app_bar.dart';
import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:http/http.dart' as http;

import '../product_list_form.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class EntradaForm extends StatefulWidget{
  EntradaForm({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _EntradaFormState createState() => _EntradaFormState();
}

class _EntradaFormState extends State<EntradaForm> {
  final _fKey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _productorName = "";
  String _codigoProductor = "";
  String _cedula = "";
  String _comunidad = "";
  String _transporte = "Caro";
  final List<String> medios = ['Caro', 'Avion'];

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final DondeFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();

  final List<Producto> productos = [];

  @override
  void initState() {
    stepperPage.productos = productos;
    productList.productos = productos;
    super.initState();
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
              key: _fKey,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        "Entrada De Mercaderia - Ficha n°1",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    InputDatePickerFormField(
                      onDateSaved: (value) => {
                        _fechaUno = value.toString()
                      },
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021, 1, 1),
                      lastDate:  DateTime(2060, 1, 01)
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                        onChanged: (value) => {
                          _usario = value
                        },
                        decoration: const InputDecoration(labelText: 'Quien'),
                        initialValue: 'Isaac',
                        attribute: 'quien',
                        onSaved: (value) => {
                            _usario = value
                        },
                        items: [
                          'Isaac',
                          'Yollanda',
                          'Nube',
                          'Veronica',
                          'Anita'
                        ].map((quien) => DropdownMenuItem(
                            value: quien,
                            child: Text("$quien",
                                    textAlign: TextAlign.left)
                        )).toList()),
                    SizedBox(height: 10),
                    SearchableDropdown.single(
                      items: [
                        'Yollanda',
                        'Nube',
                        'Veronica',
                        'Anita'
                      ].map((quien) => DropdownMenuItem(
                          value: quien,
                          child: Row(
                            children: [
                              Text("$quien",
                                  textAlign: TextAlign.left),
                              Expanded(flex: 1, child: Container()),
                              Text("Limite productor",
                                  textAlign: TextAlign.right)
                            ],
                          )))
                          .toList(),
                      value: _productorName,
                      hint: "Select one",
                      searchHint: "Select one",
                      onChanged: (value) {
                          _productorName = value;
                      },
                      isExpanded: true,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Codigo de Producto',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (value) {
                        _codigoProductor = value;
                      },
                      initialValue: _codigoProductor,
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
                      initialValue: _cedula,
                      decoration: const InputDecoration(
                        labelText: 'ID',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (value) {
                        _cedula = value;
                      },
                      autofocus: true,
                      focusNode: IdFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(DondeFocusNode);
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: _comunidad,
                      decoration: const InputDecoration(
                        labelText: 'Ciudad / Comunidad',
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      onSaved: (value) {
                        _comunidad = value;
                      },
                      autofocus: true,
                      focusNode: DondeFocusNode,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(DondeFocusNode);
                      },
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                        initialValue: _transporte,
                        attribute: 'mala',
                        onSaved: (value) {
                          _transporte = value;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Medio de Transporte',
                        ),
                        items: medios.map((medio) => DropdownMenuItem(
                                value: medio,
                                child: Text("$medio", textAlign: TextAlign.center)))
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
                        height: 400,
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

  getEntrada() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'authenticate/';
    //
  }
  void _validateInputs() {
    _fKey.currentState.save();
 }
}
