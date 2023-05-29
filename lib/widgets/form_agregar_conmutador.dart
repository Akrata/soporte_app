import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/conmutador_request.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/pinpad_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../models/conmutador.dart';
import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarConmutador extends StatelessWidget {
  bool esEdit = false;
  Conmutador? conmutadorActual;

  FormAgregarConmutador(
      {super.key, required this.esEdit, this.conmutadorActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final conmutador = Provider.of<ConmutadorRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  value: esEdit
                      ? listaSucursales.firstWhere(
                          (element) => element.id == conmutadorActual!.sucursal)
                      : null,
                  decoration: InputDecoration(hintText: 'Sucursal'),
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    esEdit
                        ? conmutadorActual!.sucursal = value!.id
                        : conmutador.conmutadorParaAgregar.sucursal = value!.id;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? conmutadorActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.ip = value
                      : conmutador.conmutadorParaAgregar.ip = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  initialValue: esEdit ? conmutadorActual!.nombre : null,
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.nombre = value
                      : conmutador.conmutadorParaAgregar.nombre = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  initialValue: esEdit ? conmutadorActual!.observaciones : null,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.observaciones = value
                      : conmutador.conmutadorParaAgregar.observaciones = value,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                esEdit
                    ? conmutador.editConmutador(conmutadorActual!)
                    : conmutador
                        .agregarConmutador(conmutador.conmutadorParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
