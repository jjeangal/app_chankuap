import 'package:app_chankuap/src/Widgets/selectMaterial.dart';
import 'package:app_chankuap/src/app_bars/form_app_bar.dart';
import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../product_list_form.dart';

class SalidaForm extends StatefulWidget{
  SalidaForm({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _SalidaFormState createState() => _SalidaFormState();
}


class _SalidaFormState extends State<SalidaForm> {
  final  _fbkey = new GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _cliente = "";
  String _transporte = "Caro";
  final List<String> medios = ['Caro', 'Avion'];

  final nameFocusNode = FocusNode();
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
                  "Salida De Mercaderia",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              InputDatePickerFormField(
                  onDateSaved: (value) => {
                    _fechaUno = value.toString()
                  },
                  firstDate: DateTime(2021, 1, 1),
                  lastDate:  DateTime(2060, 1, 01)
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
                  items: ['Isaac', 'Yollanda', 'Nube', 'Veronica', 'Anita']
                      .map((quien) => DropdownMenuItem(
                          value: quien,
                          child: Text("$quien", textAlign: TextAlign.center)))
                      .toList()),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _cliente,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                validator: (userName) {
                  if (userName.isEmpty) {
                    return 'Name is required';
                  }
                  if (userName.length < 3) {
                    return 'Name is too short';
                  }
                  return null;
                },
                onSaved: (cliente) {
                  _cliente = cliente;
                },
                autofocus: true,
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
              ),
              SizedBox(height: 10),
              FormBuilderDropdown(
                initialValue: _transporte,
                  onSaved: (value) => _transporte = value,
                  attribute: 'medio',
                  decoration: const InputDecoration(
                    labelText: 'Medio de Transporte',
                  ),
                  items: medios.map((medio) => DropdownMenuItem(
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
                  height: 400,
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
      print(_transporte +" " + _cliente + " " + _usario + " " + _fechaUno);
      Navigator.pop(context);
    }
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

