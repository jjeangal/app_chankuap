import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_object.dart';

class ProductList extends StatefulWidget {
  final List<Producto> products;

  const ProductList({Key key, this.products}) : super(key: key);

  @override
  ProductListState createState() => ProductListState();
}


class ProductListState extends State<ProductList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemCount: widget.products.length,
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
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Color(0xff073B3A))),
        child: Stack(
          children: [
            Align(
                alignment: Alignment(-0.8, -0.5),
                child: Container(
                    child: Text(
                  widget.products[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ))),
            Align(
                alignment: Alignment(-0.8, 0.5),
                child: Container(
                    child: Text(
                  widget.products[index].getNumeroLote(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ))),
            Align(
                alignment: Alignment(0.5, -0.5),
                child: Container(
                    child: Text(
                  widget.products[index].cantidad.toString() +
                      "L",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ))),
            Align(
                alignment: Alignment(0.5, 0.5),
                child: Container(
                    child: Text(
                  '0.25\$',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ))),
            Align(
                alignment: Alignment(1, 0),
                child: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.do_disturb_on_outlined),
                  onPressed: () => print("el"),
                ))
          ],
        ));
  }
}
