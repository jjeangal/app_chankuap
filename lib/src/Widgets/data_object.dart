import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

@JsonSerializable()
class EntradaTrans {
  final String fecha_uno;
  final String fecha_dos;
  final int quien;
  final String productor;
  final String p_code;
  final int ID;
  final String comunidad;
  final String transporte;

  final List<Producto> lotes;

  EntradaTrans(this.fecha_uno, this.fecha_dos, this.quien, this.productor,
      this.p_code, this.ID, this.comunidad, this.transporte, this.lotes);

  EntradaTrans.fromJson(Map<String, dynamic> json)
      : fecha_uno = json['date'],
        fecha_dos = json['fecha-2'],
        quien = json['username'],
        ID = json['PROVIDER_ID'],
        comunidad = json['communidad'],
        productor = json['productor'],
        p_code = json['p_code'],
        transporte = json['transporte'],
        lotes = json['products'].toJsonList;

  getCode() {
    return this.p_code;
  }

  getLotes() {
    return this.lotes;
  }

  Map<String, dynamic> toJson() => {
    "date": fecha_uno,
    "username": quien,
    "PROVIDER_ID": ID,
    "products": lotes.map((e) => e.toJson()).toList(),
  };
}

@JsonSerializable()
class SalidaTrans {
  final String cliente;
  final int quien;
  final String transporte;
  final String fecha_uno;
  final String fecha_dos;
  final List<Producto> lotes;

  SalidaTrans(this.cliente, this.quien, this.transporte, this.fecha_uno, this.fecha_dos, this.lotes);

  SalidaTrans.fromJson(Map<String, dynamic> json)
      : fecha_uno = json['date'],
        fecha_dos = json['fecha-2'],
        quien = json['username'],
        transporte = json['transporte'],
        cliente = json['cliente'],
        lotes = json['products'].toJsonList;

  Map<String, dynamic> toJson() => {
    "date": fecha_uno,
    "username": quien,
    "cliente": cliente,
    "products": lotes.map((e) => e.toJson()).toList(),
  };
}

class Producto {
  final int id;
  final String name;
  final int cantidad;
  final int unidad;
  final int precio;
  final String organico;
  final String comunidad;
  final String comb_id;
  final String bodega;

  List<Map<String, dynamic>> ListProducts;

  Producto(this.id, this.name,
      this.cantidad, this.unidad, this.precio, this.organico, this.comunidad):
      this.comb_id = 'M',
      this.bodega = 'B01';

  Producto.fromJson(Map<String, dynamic> json) :
      id = json['PRODUCT_ID'],
      comb_id = json['COMB_ID'],
      cantidad = json['quantity'],
      unidad = json['unit'],
      precio = json['price'],
      name = json['name'],
      organico = json['organico'],
      comunidad = json['comunidad'],
      bodega = json['bodega'];


  Map<String, dynamic> toJson() => {
    "PRODUCT_ID": id,
    "COMB_ID": 'M',
    "lote": getNumeroLote(),
    "quantity": cantidad,
    "unit": unidad,
    "price": precio,
    "bodega": "BO1"
  };
 dynamic toJsonList(List<Producto> listToParse){

    ListProducts = [];

    for(Producto product in listToParse){
      ListProducts.add(product.toJson());
    }
    print(ListProducts);
    return ListProducts;

  }

  getNumeroLote() {
    return '${name}' + '${comunidad}' + '${organico}' + '${id}' + DateFormat(
        'ddMMyyyy').format(DateTime.now());
  }
}

class EntradaOverview {

  final int trans_id;
  final String fecha;
  final String usario;
  final int provider_id;

  EntradaOverview(this.trans_id, this.fecha, this.usario, this.provider_id);
}

class SalidaOverview {

  final int trans_id;
  final String cliente;
  final String fecha;

  SalidaOverview(this.trans_id, this.cliente, this.fecha);
}

class SendEntrada {
  final String fecha;
  final String name;
  final String ID;
  final List<Producto> productos;

  SendEntrada(this.fecha, this.name, this.ID, this.productos);
}

Map myMap = {
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
  {'name': '', 'code': ''},
} as Map;