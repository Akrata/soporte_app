// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/licencia_request.dart';

import '../models/licencia.dart';

class FormAgregarLicencia extends StatelessWidget {
  final bool esEdit;
  final Licencia? licenciaActual;

  const FormAgregarLicencia(
      {super.key, required this.esEdit, this.licenciaActual});

  @override
  Widget build(BuildContext context) {
    final listaEquipos = Provider.of<EquiposRequest>(context).listaEquipos;

    // final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final licencia = Provider.of<LicenciaRequest>(context);

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
                      ? listaEquipos.firstWhere(
                          (element) => element.id == licenciaActual!.equipo)
                      : null,
                  decoration: const InputDecoration(hintText: 'Equipo'),
                  items: listaEquipos
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.ip),
                          ))
                      .toList(),
                  onChanged: (value) {
                    esEdit
                        ? licenciaActual!.equipo = value!.id
                        : licencia.licenciaParaAgregar.equipo = value!.id;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'key'),
                  initialValue: esEdit ? licenciaActual!.key : null,
                  onChanged: (value) => esEdit
                      ? licenciaActual!.key = value
                      : licencia.licenciaParaAgregar.key = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  initialValue: esEdit ? licenciaActual!.tipo : null,
                  onChanged: (value) => esEdit
                      ? licenciaActual!.tipo = value
                      : licencia.licenciaParaAgregar.tipo = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   keyboardType: TextInputType.multiline,
                //   minLines: 3,
                //   maxLines: null,
                //   initialValue: esEdit ? conmutadorActual!.observaciones : null,
                //   decoration: InputDecoration(labelText: 'Observaciones'),
                //   onChanged: (value) => esEdit
                //       ? conmutadorActual!.observaciones = value
                //       : conmutador.conmutadorParaAgregar.observaciones = value,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
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
                    ? licencia.editLicencia(licenciaActual!)
                    : licencia.agregarLicencia(licencia.licenciaParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Agregar")),
        ],
      ),
    );
  }
}
