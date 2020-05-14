import 'package:lista_producto/models/producto.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // crud -> create, read, update, delete
  Database db;

  // String nombre;
  // int cantidad;
  // int total;
  // int precio;
  Future<Database> initDB() async {
    return db = await openDatabase('productos.db', version: 1,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE Productos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            cantidad INTEGER,
            total REAL,
            precio REAL
          )
        ''');
    });
  }

  Future guardarProducto(Producto producto) async {
    Database myDb = await initDB();
    int res = await myDb.insert('Productos', producto.toJson());
    if (res >= 1) {
      print('******GUARDADO EXITOSAMENTE*****');
    } else {
      print('******NO GUARDADO EXITOSAMENTE*****');
    }
  }

  Future<List<Producto>> obtenerProductos() async {
    Database myDb = await initDB();
    List res = await myDb.query('Productos');
    if (res.length == 0) {
      print('******LISTA VACIA*****');
      return [];
    } else {
      print('******LISTA CON DATOS*****');
      return List<Producto>.from(res.map((json) {
        return Producto.fromJson(json);
      }));
    }
  }

  Future dispose() async {
    await db.close();
  }
}
