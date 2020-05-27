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

  // CREATE
  Future guardarProducto(Producto producto) async {
    Database myDb = await initDB();
    int res = await myDb.insert('Productos', producto.toJson());
    if (res >= 1) {
      print('******GUARDADO EXITOSAMENTE*****');
    } else {
      print('******NO GUARDADO EXITOSAMENTE*****');
    }
  }

  // READ
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

  // UPDATE
  Future<bool> actualizarProducto(Producto producto) async {
    Database myDb = await initDB();
    int resp = await myDb.update(
      'Productos',
      {
        'cantidad' : producto.cantidad,
        'total' : producto.total,
      },
      where: 'id = ?',
      whereArgs: ['${producto.id}'],
    );

    if(resp >= 1) return true;
    else return false;
  }

  // DELETE
  Future<bool> borrarProducto(Producto producto) async {
    Database myDb = await initDB();
    int resp = await myDb
        .delete('Productos', where: 'id = ?', whereArgs: ['${producto.id}']);
    if (resp >= 1)
      return true;
    else
      return false;
  }

  Future dispose() async {
    await db.close();
  }
}
