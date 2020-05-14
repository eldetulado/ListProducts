import 'package:lista_producto/models/producto.dart';

class ListDummy {
  
  static final ListDummy _instancia = ListDummy._internal();
  
  //constructor privado
  ListDummy._internal();

  List items = List<Producto>();

  factory ListDummy() {
    return _instancia;
  }


  agregarArticulo(Producto producto) {
    print('articulo agregado exitosamente');
    items.add(producto);
  }

  calcularTotalProductos(){

    int resultado = 0;

    for(int i = 0; i < items.length; i++){
      resultado = resultado + items[i].total;
    }

    return resultado;    
  }
}
