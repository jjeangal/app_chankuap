import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forms/entradas/add_entrada_form.dart';
import '../forms/salidas/add_salida_form.dart';
import '../pages/Entrada.dart';
import '../pages/Salida.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key key, this.page}) : super(key: key);

  final int page;

  @override
  State<StatefulWidget> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final Entrada entrada = Entrada();
  final Salida salida = Salida();
  final AddSalidaForm _addSalidaForm = AddSalidaForm();
  final AddEntradaForm _addEntradaForm = AddEntradaForm();

  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      onPressed: () => {
        if (widget.page == 1)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _addEntradaForm),
          ),
        if (widget.page == 2)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _addSalidaForm),
          ),
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Color(0xff073B3A))),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 6,
              child:
                  Text("Anadir", style: TextStyle(color: Color(0xff073B3A)))),
          Icon(Icons.add, color: Color(0xff073B3A)),
        ],
      ),
    );
  }
}
