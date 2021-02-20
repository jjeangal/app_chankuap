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
  SalidaForm({Key key, this.id, this.trans}) : super(key: key);

  final SalidaOverview trans;

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
  String _transporte = "Carro";

  final nameFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();
  SalidaOverview trans;

  final List<Producto> productos = [];

  @override
  void initState() {
    this.trans = widget.trans;
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
                  "Salida De Mercaderia - Ficha n°" +
                      widget.trans.trans_id.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              InputDatePickerFormField(
                initialDate: DateTime.parse(widget.trans.fecha),
                  onDateSaved: (value) => {
                    _fechaUno = value.toString()
                  },
                  firstDate: DateTime(2020, 1, 1),
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
                  initialValue: 'Isaac',
                  attribute: 'quien',
                  items: ['Isaac', 'Yollanda', 'Nube', 'Veronica', 'Anita']
                      .map((quien) => DropdownMenuItem(
                          value: quien,
                          child: Text("$quien", textAlign: TextAlign.center)))
                      .toList()),
              SizedBox(height: 10),
              TextFormField(
                initialValue: this.widget.trans.cliente,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                validator: (userName) {
                  if (userName.isEmpty) {
                    return 'El nombre del cliente es obligatorio';
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
                initialValue: "Carro",
                  onSaved: (value) => _transporte = value,
                  attribute: 'medio',
                  decoration: const InputDecoration(
                    labelText: 'Medio de Transporte',
                  ),
                  items: ['Carro', 'Avion'].map((medio) => DropdownMenuItem(
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
        backgroundColor: Color(0xff073B3A),
      ),
    );
  }

  void _validateInputs() {
    if (_fbkey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _fbkey.currentState.save();
      Navigator.pop(context);
    }
  }
}



