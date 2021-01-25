import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/data_object.dart';

import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StepperPage extends StatefulWidget {
  StepperPage({Key key, productos}) : super(key: key);

  List<Producto> productos;

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {

  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  final LoteFocusNode = FocusNode();
  final CantidadFocusNode = FocusNode();
  final PrecioFocusNode = FocusNode();
  final TextEditingController _typeAheadController = TextEditingController();

  int id;
  String name = "";
  double cantidad;
  int unidad = 0;
  String precio = "";
  String organico = "";
  String comunidad = "";
  List<Step> steps;

  @override
  void initState() {
    _buildSteps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Anadir Materia Prima'),
          ),
        child: SafeArea(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              switch (orientation) {
                case Orientation.portrait:
                  return _buildStepper(StepperType.vertical);
                case Orientation.landscape:
                  return _buildStepper(StepperType.horizontal);
                default:
                  throw UnimplementedError(orientation.toString());
              }
            },
          ),
        ),
      )
    );
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    return CupertinoStepper(
        type: type,
        steps: _buildSteps(),
        currentStep: currentStep,
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
        onStepContinue: () {
          setState(() {
            if (currentStep < 0)
              currentStep++;
            else
              _registerMateria();
          });
        });
  }

  Widget _buildStep() {
    return Scaffold(
       body: SafeArea(
          child: Form(
            key: _formKey,
              child: Column(children: <Widget>[
                  TypeAheadFormField(
                    onSaved: (value) => name = value,
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de Producto',
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
                  ),
                  FormBuilderDropdown(
                      decoration: const InputDecoration(labelText: 'Organico / Convencional'),
                      initialValue: "Organico",
                      attribute: 'quien',
                      onSaved: (value) => {
                        if(value == 'Organico') organico = "O",
                        if(value == 'Convencional') organico = "C"
                      },
                      items: [
                        'Organico',
                        'Convencional'
                      ].map((quien) => DropdownMenuItem(
                          value: quien,
                          child: Text("$quien",
                              textAlign: TextAlign.left)
                      )).toList()),
                FormBuilderDropdown(
                      decoration: const InputDecoration(labelText: 'Comunidad'),
                      initialValue: "Shuar",
                      attribute: 'comunidad',
                      onSaved: (value) => {
                        if(value == 'Shuar') comunidad = "SH",
                        if(value == 'Achuar') comunidad = "ACH"
                      },
                      items: [
                        'Shuar',
                        'Achuar'
                      ].map((comu) => DropdownMenuItem(
                          value: comu,
                          child: Text("$comu",
                              textAlign: TextAlign.left)
                      )).toList()),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    onSaved: (canti) {
                      cantidad = double.parse(canti.toString());
                    },
                    autofocus: true,
                    focusNode: CantidadFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(CantidadFocusNode);
                    },
                  ),
                  FormBuilderDropdown(
                    onSaved: (uni) => unidad = _unidadToInt(uni),
                      decoration: const InputDecoration(labelText: 'Unidad'),
                      initialValue: 'g',

                      //initialValue: 1,
                      attribute: 'unidad',
                      items: ['g', 'kg', 'lb', 'ml', 'L']
                      //items: [1,2,3]
                          .map((unidad) => DropdownMenuItem(
                          value: unidad,
                          child: Text("$unidad", textAlign: TextAlign.center)))
                          .toList()),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    onSaved: (price) {
                      precio = price;
                    },
                    autofocus: true,
                    focusNode: PrecioFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(PrecioFocusNode);
                    },
                  ),
                ]
                )
            )
          )
      );
  }

  _buildSteps(){
    return <Step> [
      Step(
        title: Text("Producto"),
        subtitle: Text('Selecionar nombre y codigo'),
        content: LimitedBox(
            maxWidth: 300, maxHeight: 600, child: _buildStep())),
    ];
  }

  _registerMateria() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      try {
        var price = int.parse(precio);
        widget.productos.add(new Producto(1, name, cantidad, unidad,
            price, organico, comunidad));
        Navigator.pop(context);
      } on FormatException {
        print('Format error!');
      }
    }
  }

  _unidadToInt(String uni) {
    switch (uni) {
      case 'g':
        return 0;
      case 'kg':
        return 1;
      case 'lb':
        return 2;
      case  'ml':
        return 3;
      case 'L':
        return 4;
    }
  }
}
