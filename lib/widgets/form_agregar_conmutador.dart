// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/conmutador_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';

import '../models/conmutador.dart';
import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarConmutador extends StatelessWidget {
  final bool esEdit;
  final Conmutador? conmutadorActual;

  const FormAgregarConmutador(
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
                  decoration: const InputDecoration(hintText: 'Sucursal'),
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.nombre),
                          ))
                      .toList(),
                  onChanged: (value) {
                    esEdit
                        ? conmutadorActual!.sucursal = value!.id
                        : conmutador.conmutadorParaAgregar.sucursal = value!.id;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? conmutadorActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.ip = value
                      : conmutador.conmutadorParaAgregar.ip = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  initialValue: esEdit ? conmutadorActual!.nombre : null,
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.nombre = value
                      : conmutador.conmutadorParaAgregar.nombre = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  initialValue: esEdit ? conmutadorActual!.observaciones : null,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                  onChanged: (value) => esEdit
                      ? conmutadorActual!.observaciones = value
                      : conmutador.conmutadorParaAgregar.observaciones = value,
                ),
                const SizedBox(
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
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                esEdit
                    ? conmutador.editConmutador(conmutadorActual!)
                    : conmutador
                        .agregarConmutador(conmutador.conmutadorParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Agregar")),
        ],
      ),
    );
  }
}
