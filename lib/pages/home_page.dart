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
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),

      // para la siguiente clase
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
            future: provider.obtenerProductos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Producto> datos = snapshot.data;
                if (datos.length == 0) {
                  return Center(child: Text('No items'));
                } else {
                  return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder: (BuildContext context, int indice) {
                      return _item(datos[indice]);
                    },
                  );
                }
              }
              return Text('cargando datos');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RegisterProductPage.namePage);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _item(Producto producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(left: 16),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 16),
        color: Colors.blue,
        child: Icon(Icons.update, color: Colors.white),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          bool status = await provider.borrarProducto(producto);
          print(status);
        }
      },
      child: Card(
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
                  onPressed: () async {
                    // implementar metodo
                    producto.cantidad = producto.cantidad + 1;

                    producto.calcularTotal(producto.cantidad, producto.precio);
                    bool resp = await provider.actualizarProducto(producto);
                    if (resp) setState(() {});
                  },
                  child: Icon(Icons.add, color: Colors.purple),
                ),
                // $contador.toString()
                Text('${producto.cantidad}'),
                FlatButton(
                  onPressed: () async {
                    // implementar metodo
                    if (producto.cantidad >= 1) {
                      producto.cantidad = producto.cantidad - 1;
                    }
                    producto.calcularTotal(producto.cantidad, producto.precio);
                    bool resp = await provider.actualizarProducto(producto);
                    if (resp) setState(() {});
                  },
                  child: Icon(Icons.remove, color: Colors.red),
                ),
                Text('${producto.total}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
