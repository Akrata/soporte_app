// ignore_for_file: unused_local_variable, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarEquipo extends StatelessWidget {
  final bool esEdit;
  final Equipo? equipoActual;

  const FormAgregarEquipo({super.key, required this.esEdit, this.equipoActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;

    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final equipo = Provider.of<EquiposRequest>(context);

    final DateTime now = DateTime.now();

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
                      ? listaSucursales.firstWhere((element) =>
                          element.id ==
                          equipoActual!.expand!.sector.expand!.sucursal.id)
                      : null,
                  decoration: const InputDecoration(hintText: 'Sucursal'),
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.nombre),
                          ))
                      .toList(),
                  onChanged: (value) async {
                    try {
                      await secYTon.getSectorSegunSucursal(value!.id);
                      if (esEdit) {
                        secYTon.cambiarSucursal(true);
                      }
                      esEdit
                          ? equipoActual!.expand!.sector.sucursal = value.id
                          : equipo.sucursal = value.id;
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!esEdit)
                  DropdownButtonFormField(
                    decoration: const InputDecoration(hintText: 'Sector'),
                    items: secYTon.listaSectoresValue
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.nombre),
                            ))
                        .toList(),
                    onChanged: (value) async {
                      equipo.equipoParaAgregar.sector = value!.id;
                    },
                  ),
                if (esEdit)
                  DropdownButtonFormField(
                    value: secYTon.abriendoSucursal
                        ? null
                        : sector.listaSectores.firstWhere((element) =>
                            element.id == equipoActual!.expand!.sector.id),
                    decoration: const InputDecoration(hintText: 'Sector'),
                    items: secYTon.abriendoSucursal
                        ? secYTon.listaSectoresValue
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nombre),
                                ))
                            .toList()
                        : sector.listaSectores
                            .where((element) =>
                                element.sucursal ==
                                equipoActual!
                                    .expand!.sector.expand!.sucursal.id)
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nombre),
                                ))
                            .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? equipoActual!.sector = value!.id
                          : equipo.equipoParaAgregar.sector = value!.id;
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Nombre de equipo'),
                  initialValue: esEdit ? equipoActual!.nombre : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.nombre = value
                      : equipo.equipoParaAgregar.nombre = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? equipoActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.ip = value
                      : equipo.equipoParaAgregar.ip = value,
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   child: DatePickerDialog(
                //       initialDate: equipoActual?.ultimoMantenimiento ?? now,
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime(2030)),
                // ),
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Licencia Windows'),
                //   initialValue: esEdit ? equipoActual!.licenciaWindows : null,
                //   onChanged: (value) => esEdit
                //       ? equipoActual!.licenciaWindows = value
                //       : equipo.equipoParaAgregar.licenciaWindows = value,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Licencia Office'),
                //   initialValue: esEdit ? equipoActual!.licenciaOffice : null,
                //   onChanged: (value) => esEdit
                //       ? equipoActual!.licenciaOffice = value
                //       : equipo.equipoParaAgregar.licenciaOffice = value,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? equipoActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.observaciones = value
                      : equipo.equipoParaAgregar.observaciones = value,
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
                secYTon.cambiarSucursal(false);
                Navigator.pop(context);
              },
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                secYTon.cambiarSucursal(false);
                esEdit
                    ? equipo.editEquipo(equipoActual!)
                    : equipo.agregarEquipo(equipo.equipoParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Confirmar")),
        ],
      ),
    );
  }
}
