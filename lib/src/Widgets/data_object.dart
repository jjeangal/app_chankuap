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
        lotes = json['products'].map((e) => Producto.fromJson(e)).toList().cast<Producto>();

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
        lotes = json['products'].map((e) => Producto.fromJson(e)).toList().cast<Producto>();

  Map<String, dynamic> toJson() => {
    "date": fecha_uno,
    "username": quien,
    "cliente": cliente,
    "products": lotes.map((e) => e.toJson()).toList(),
  };
}

class Producto {
  final int id;
  final double cantidad;
  final int unidad;
  final int precio;
  final String organico;
  final String comunidad;
  final String comb_id;
  final String name;
  final String bodega;

  List<Map<String, dynamic>> ListProducts;

  Producto(this.id, this.name,
      this.cantidad, this.unidad, this.precio, this.organico, this.comunidad):
      this.comb_id = 'M',
      this.bodega = 'B01';

  Producto.fromJson(Map<String, dynamic> json) :
      id = json['PRODUCT_ID'],
      comb_id = json['COMB_ID'],
      name = json['name'],
      cantidad = double.parse(json['quantity'].toString()),
      unidad = json['unit'],
      precio = json['price'],
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
    return ListProducts;
  }

  getNumeroLote() {
    return '${name}' + '${comunidad}' + '${organico}' + '${id}' + DateFormat(
        'ddMMyyyy').format(DateTime.now());
  }
}

@JsonSerializable()
class ListEntradaOverviews {

  final List<EntradaOverview> ListEntradas;

  ListEntradaOverviews.fromJson(Map<String, dynamic> json) :
        ListEntradas = json['overviews'].toJsonList;

  Map<String, dynamic> toJson() => {
    "overviews": ListEntradas.map((e) => e.toJson()).toList(),
  };

  ListEntradaOverviews(this.ListEntradas);
}

@JsonSerializable()
class EntradaOverview {

  final int trans_id;
  final String fecha;
  final int usario;
  final int provider_id;

  List<Map<String, dynamic>> ListSalidas;

  EntradaOverview.fromJson(Map<String, dynamic> json) :
    trans_id = json['TRANS_ID'],
    fecha = json['date'],
    usario = json['username'],
    provider_id = json['PROVIDER_ID'];

  Map<String, dynamic> toJson() => {
    "TRANS_ID": trans_id,
    "date": fecha,
    "username": usario,
    "PROVIDER_ID": provider_id
  };

  dynamic toJsonList(List<EntradaOverview> listToParse){

    ListSalidas = [];

    for(EntradaOverview salida in listToParse){
      ListSalidas.add(salida.toJson());
    }
    print(ListSalidas);
    return ListSalidas;

  }

  EntradaOverview(this.trans_id, this.fecha, this.usario, this.provider_id);
}


@JsonSerializable()
class ListSalidaOverviews {

  final List<SalidaOverview> ListSalidas;

  ListSalidaOverviews.fromJson(Map<String, dynamic> json) :
      ListSalidas = json['overviews'];

  Map<String, dynamic> toJson() => {
      "overviews": ListSalidas.map((e) => e.toJson()).toList(),
  };

  ListSalidaOverviews(this.ListSalidas);
}

class SalidaOverview {

  final int trans_id;
  final int username;
  final String cliente;
  final String fecha;

  List<Map<String, dynamic>> ListSalidas;

  SalidaOverview.fromJson(Map<String, dynamic> json) :
        trans_id = json['TRANS_OUT_ID'],
        fecha = json['date'],
        username = json['username'],
        cliente = json['cliente'];

  Map<String, dynamic> toJson() => {
    "TRANS_OUT_ID": trans_id,
    "date": fecha,
    "username": username,
    "PROVIDER_ID": cliente
  };

  getId() {
    return this.trans_id;
  }

  dynamic toJsonList(List<SalidaOverview> listToParse){

    ListSalidas = [];

    for(SalidaOverview salida in listToParse){
      ListSalidas.add(salida.toJson());
    }
    print(ListSalidas);
    return ListSalidas;
  }

  SalidaOverview(this.trans_id, this.username, this.cliente, this.fecha);
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
