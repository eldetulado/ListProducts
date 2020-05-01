import 'package:flutter/material.dart';
import 'package:lista_producto/models/list_dummy.dart';
import 'package:lista_producto/models/producto.dart';

class RegisterProductPage extends StatelessWidget {
  static const namePage = 'register_product';

  final listDummy = ListDummy();
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
            onPressed: () {
              final prod = Producto(
                nombre: nombreController.text,
                precio: int.parse(precioController.text),
                cantidad: 0,
                total: 0,
              );
              listDummy.agregarArticulo(prod);
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
