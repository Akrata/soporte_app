import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TemporalVnc {
  TemporalVnc();
  Future<void> generarArchivoVNC(String ip, int puerto) async {
    final directorioTemporal = await getTemporaryDirectory();
    final rutaArchivo = '${directorioTemporal.path}/conexion.vnc';
    final contenido = '[Connection]\nHost=$ip\nPort=$puerto';

    final archivo = File(rutaArchivo);
    await archivo.writeAsString(contenido);

    final url = archivo.uri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el archivo .vnc';
    }

    // Establecer un tiempo de vida para el archivo temporal
    Future.delayed(Duration(seconds: 2), () {
      archivo.deleteSync();
    });
  }
}
