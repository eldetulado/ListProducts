// body: Column(
//         children: <Widget>[
//           Text('$contador', style: TextStyle(fontSize: 64)),
//           RaisedButton(
//             onPressed: () {
//               setState(() {
//                 // setState redibuja la pantalla
//                 // volver a ejecutar el metodo build
//                 contador = contador + 1;
//               });
//             },
//             child: Text('aumentar'),
//           ),
//           RaisedButton(
//             onPressed: () {
//               contador = contador - 1;
//               setState(() {});
//             },
//             child: Text('disminuir'),
//           ),
//         ],
//       ),
import 'package:flutter/material.dart';
import 'package:lista_producto/models/list_dummy.dart';
import 'package:lista_producto/models/producto.dart';
import 'package:lista_producto/pages/register_product_page.dart';
import 'package:lista_producto/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  static const namePage = 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tituloAppBar = 'Lista productos';
  int contador = 0;

  // para la siguiente clase
  // ListDummy listaArticulos = ListDummy();
  DBProvider provider = DBProvider();

  @override
  Widget build(BuildContext context) {
    print('entrando al metodo build');
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBar),
        actions: <Widget>[
          // Center(child: Text('${listaArticulos.calcularTotalProductos()}'))
        ],
      ),

      // para la siguiente clase
      body: FutureBuilder(
          initialData: [],
          future: provider.obtenerProductos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List datos = snapshot.data;
              if (datos.length == 0) {
                return Text('No items');
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (BuildContext context, int indice) {
                      return _item(snapshot.data.items[indice]);
                    },
                  ),
                );
              }
            }
            return Text('cargando datos');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RegisterProductPage.namePage);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _item(Producto producto) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      child: Container(
        child: ListTile(
          // leading: Image.network(
          //   'https://ichef.bbci.co.uk/news/ws/410/amz/worldservice/live/assets/images/2014/11/05/141105131956_leche_624x351_thinkstock.jpg',
          //   fit: BoxFit.cover,
          //   width: 50,
          // ),
          title: Text(producto.nombre),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  // implementar metodo
                  producto.cantidad = producto.cantidad + 1;

                  producto.calcularTotal(producto.cantidad, producto.precio);
                  setState(() {});
                },
                child: Icon(Icons.add, color: Colors.purple),
              ),
              // $contador.toString()
              Text('${producto.cantidad}'),
              FlatButton(
                onPressed: () {
                  // implementar metodo
                  if (producto.cantidad >= 1) {
                    producto.cantidad = producto.cantidad - 1;
                  }
                  producto.calcularTotal(producto.cantidad, producto.precio);
                  setState(() {});
                },
                child: Icon(Icons.remove, color: Colors.red),
              ),
              Text('${producto.total}'),
            ],
          ),
        ),
      ),
    );
  }
}
