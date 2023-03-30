class FechaFormater {
  static String formatearFecha(String fecha) {
    return fecha.split(' ').first.split('-').reversed.join('-');
  }
}
