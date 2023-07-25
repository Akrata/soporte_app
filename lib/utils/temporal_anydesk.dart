// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class TemporalAnydesk {
  TemporalAnydesk();
  Future<void> generarArchivoAnydesk(String? id) async {
    String url = "anydesk:$id";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Manejar el caso en el que no se pueda abrir AnyDesk.
      // Puedes mostrar un mensaje de error o sugerir al usuario que instale AnyDesk.
    }

    // Establecer un tiempo de vida para el archivo temporal
    // Future.delayed(Duration(seconds: 2), () {
    //   archivo.deleteSync();
    // });
  }
}
