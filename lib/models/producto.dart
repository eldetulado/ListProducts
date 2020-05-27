class Producto {
  int id;
  String nombre;
  int cantidad;
  double total;
  double precio;

  Producto({this.nombre, this.cantidad, this.total, this.precio});

  // {
  //   "nombre": "leche",
  //   "cantidad": 1,
  //   "total": 1500,
  //   "precio": 1500
  // }

  Producto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nombre = json['nombre']; // leche
    this.cantidad = json['cantidad']; // 1
    this.total = json['total']; // 1500
    this.precio = json['precio']; // 1500
  }

  Map<String, dynamic> toJson() {
    return {
      "nombre": this.nombre,
      "cantidad": this.cantidad,
      "total": this.total,
      "precio": this.precio
    };
  }

  void calcularTotal(int cantidad, double precio) {
    this.total = (cantidad * precio) / 1;
  }
}
