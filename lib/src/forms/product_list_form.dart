import 'package:app_chankuap/src/Widgets/data_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProductListForm extends StatefulWidget {
  List<Producto> productos;

  ProductListForm({Key key, productos}) : super(key: key);

  @override
  _ProductListFormState createState() => _ProductListFormState();
}

class _ProductListFormState extends State<ProductListForm> {

  Producto product;
  String name = "Me";
  String lote = "Loe";
  int can = 10;
  int uni = 1;
  double precio = 15;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.productos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 60,
          color: Color(0xffEFEFEF),
          child: _buildProductBox(context, index),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildProductBox(BuildContext context, int index) {
    return new Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Color(0xff073B3A))),
        child: Form(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: Container(
                      child: Text(
                        widget.productos[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ))),
              Align(
                  alignment: Alignment(-0.8, 0.5),
                  child: Container(
                      child: Text(
                    widget.productos[index].getNumeroLote(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ))),
              Align(
                  alignment: Alignment(0.5, -0.5),
                  child: Container(
                      child: Text(
                    '${widget.productos[index].cantidad}' +
                        '${widget.productos[index].unidad}',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ))),
              Align(
                  alignment: Alignment(0.5, 0.5),
                  child: Container(
                      child: Text(
                    '${widget.productos[index].precio}\$',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ))),
              Align(
                  alignment: Alignment(1, 0),
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(Icons.do_disturb_on_outlined),
                    onPressed: () => {
                      print("el"),
                    }
                  ))
            ],
          )
        )
    );
  }
}
