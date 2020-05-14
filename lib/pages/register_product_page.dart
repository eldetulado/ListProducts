import 'package:flutter/material.dart';
// import 'package:lista_producto/models/list_dummy.dart';
import 'package:lista_producto/models/producto.dart';
import 'package:lista_producto/providers/db_provider.dart';

class RegisterProductPage extends StatelessWidget {
  static const namePage = 'register_product';

  // final listDummy = ListDummy();
  final DBProvider provider = DBProvider();
  final nombreController = TextEditingController();
  final precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro producto')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: nombreController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre',
              hintText: 'Pan',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: precioController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Precio',
              hintText: '123',
            ),
          ),
          SizedBox(height: 50),
          RaisedButton.icon(
            onPressed: () async {
              final prod = Producto(
                nombre: nombreController.text,
                precio: double.parse(precioController.text),
                cantidad: 0,
                total: 0,
              );
              await provider.guardarProducto(prod);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.send),
            label: Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
