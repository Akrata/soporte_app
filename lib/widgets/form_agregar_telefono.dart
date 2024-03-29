// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/telefono_request.dart';

import '../models/telefono.dart';
import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarTelefono extends StatelessWidget {
  final bool esEdit;
  final Telefono? telefonoActual;
  const FormAgregarTelefono(
      {super.key, required this.esEdit, this.telefonoActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final telefono = Provider.of<TelefonoRequest>(context);

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
                          telefonoActual!.expand!.sector.expand!.sucursal.id)
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
                          ? telefonoActual!.expand!.sector.sucursal = value.id
                          : telefono.sucursal = value.id;
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
                      telefono.telefonoParaAgregar.sector = value!.id;
                    },
                  ),
                if (esEdit)
                  DropdownButtonFormField(
                    value: secYTon.abriendoSucursal
                        ? null
                        : sector.listaSectores.firstWhere((element) =>
                            element.id == telefonoActual!.expand!.sector.id),
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
                                telefonoActual!
                                    .expand!.sector.expand!.sucursal.id)
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nombre),
                                ))
                            .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? telefonoActual!.sector = value!.id
                          : telefono.telefonoParaAgregar.sector = value!.id;
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Interno'),
                  initialValue: esEdit ? telefonoActual!.interno : null,
                  onChanged: (value) => esEdit
                      ? telefonoActual!.interno = value
                      : telefono.telefonoParaAgregar.interno = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? telefonoActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? telefonoActual!.ip = value
                      : telefono.telefonoParaAgregar.ip = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? telefonoActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? telefonoActual!.observaciones = value
                      : telefono.telefonoParaAgregar.observaciones = value,
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
                    ? telefono.editTelefono(telefonoActual!)
                    : telefono.agregarTelefono(telefono.telefonoParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Confirmar ")),
        ],
      ),
    );
  }
}
