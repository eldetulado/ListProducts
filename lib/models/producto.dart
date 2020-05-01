class Producto{
  String nombre;
  int cantidad;
  int total;
  int precio;

  Producto({this.nombre, this.cantidad, this.total, this.precio});

  void calcularTotal(int cantidad, int precio){
    this.total = cantidad * precio;
  }
}