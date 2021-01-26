import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:app_chankuap/src/Widgets/selectMaterial.dart';
import 'package:app_chankuap/src/app_bars/form_app_bar.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../forms/product_list_form.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddSalidaForm extends StatefulWidget{
  AddSalidaForm({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _AddSalidaFormState createState() => _AddSalidaFormState();
}


class _AddSalidaFormState extends State<AddSalidaForm> {
  final GlobalKey<FormState> _fbkey = new GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _cliente = "";
  String _transporte = "";

  List<Producto> productos = [];

  final nameFocusNode = FocusNode();
  final stepperPage = new StepperPage();
  ProductListForm productList;

  @override
  void initState() {
    super.initState();
    productList = new ProductListForm();
    stepperPage.productos = productos;
    productList.productos = productos;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: FormAppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _fbkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: Text(
                  "Salida De Mercaderia - Ficha n°" +
                      "2(fixo)", //get latest id
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
                  initialDate: DateTime.now(),
                  onDateSaved: (value) => {
                    _fechaDos = value.toString()
                  },
                  firstDate: DateTime(2021, 1, 1),
                  lastDate:  DateTime(2060, 1, 01)
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
                      child: Text("$quien", textAlign: TextAlign.center)))
                      .toList()),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                onSaved: (cliente) {
                  _cliente = cliente;
                },
                autofocus: true,
                validator: (cliente) {
                  if (cliente.isEmpty) {
                    return 'El nombre del cliente es obligatorio';
                  }
                  return null;
                },
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
              ),
              SizedBox(height: 10),
              FormBuilderDropdown(
                initialValue: 'Carro',
                  onSaved: (value) => _transporte = value,
                  attribute: 'medio',
                  decoration: const InputDecoration(
                    labelText: 'Medio de Transporte',
                  ),
                  items: ['Carro', 'Avion']
                      .map((medio) => DropdownMenuItem(
                      value: medio,
                      child: Text("$medio", textAlign: TextAlign.center)))
                      .toList()),
              SizedBox(height: 10),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          confirmationDialog(context, "Estas seguro ?",
              title: "Confirmacion",
              confirmationText: "Click here to confirmar",
              positiveText: "Registrar", positiveAction: () {
                _validateInputs();
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _validateInputs() {
    if (_fbkey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _fbkey.currentState.save();
      _sendSalida();
    }
  }

  Future _sendSalida() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/';

    SalidaTrans trans = new SalidaTrans(_cliente, 1, _transporte, _fechaUno,
      _fechaDos, productos);

    try {
      var uriResponse = await client.post(url+endpoint,
          body: json.encode(trans));
      print(json.encode(trans));
      print(await uriResponse.statusCode);

      Navigator.pop(context);

    } finally {
      client.close();
    }
  }

  refresh() {
    setState(() {});
  }
}

/**
    TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
    autofocus: true,
    decoration: const InputDecoration(
    labelText: 'Product name',
    hintText: 'Enter product name',
    ),
    ),
    // ignore: missing_return
    suggestionsCallback: (pattern) async {
    //return await BackendService.getSuggestions(pattern);
    },
    itemBuilder: (context, suggestion) {
    return ListTile(
    title: Text(suggestion),
    );
    },
    onSuggestionSelected: (suggestion) {
    this._typeAheadController.text = suggestion;
    },
    ),**/


