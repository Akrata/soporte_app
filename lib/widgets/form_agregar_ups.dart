import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soporte_app/models/ups.dart';

import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';

import 'package:soporte_app/providers/request_providers/ups_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarUps extends StatelessWidget {
  final bool esEdit;
  final Ups? upsActual;
  const FormAgregarUps({super.key, required this.esEdit, this.upsActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final ups = Provider.of<UpsRequest>(context);

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
                          upsActual!.expand!.sector.expand!.sucursal.id)
                      : null,
                  decoration: InputDecoration(hintText: 'Sucursal'),
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    try {
                      await secYTon.getSectorSegunSucursal(value!.id);
                      if (esEdit) {
                        secYTon.cambiarSucursal(true);
                      }
                      esEdit
                          ? upsActual!.expand!.sector.sucursal = value.id
                          : ups.sucursal = value.id;
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                if (!esEdit)
                  DropdownButtonFormField(
                    decoration: InputDecoration(hintText: 'Sector'),
                    items: secYTon.listaSectoresValue
                        .map((e) => DropdownMenuItem(
                              child: Text(e.nombre),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) async {
                      ups.upsParaAgregar.sector = value!.id;
                    },
                  ),
                if (esEdit)
                  DropdownButtonFormField(
                    value: secYTon.abriendoSucursal
                        ? null
                        : sector.listaSectores.firstWhere((element) =>
                            element.id == upsActual!.expand!.sector.id),
                    decoration: InputDecoration(hintText: 'Sector'),
                    items: secYTon.abriendoSucursal
                        ? secYTon.listaSectoresValue
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.nombre),
                                  value: e,
                                ))
                            .toList()
                        : sector.listaSectores
                            .where((element) =>
                                element.sucursal ==
                                upsActual!.expand!.sector.expand!.sucursal.id)
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.nombre),
                                  value: e,
                                ))
                            .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? upsActual!.sector = value!.id
                          : ups.upsParaAgregar.sector = value!.id;
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marca'),
                  initialValue: esEdit ? upsActual!.marca : null,
                  onChanged: (value) => esEdit
                      ? upsActual!.marca = value
                      : ups.upsParaAgregar.marca = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Modelo'),
                  initialValue: esEdit ? upsActual!.modelo : null,
                  onChanged: (value) => esEdit
                      ? upsActual!.modelo = value
                      : ups.upsParaAgregar.modelo = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? upsActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? upsActual!.observaciones = value
                      : ups.upsParaAgregar.observaciones = value,
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
                secYTon.cambiarSucursal(false);
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                secYTon.cambiarSucursal(false);
                esEdit
                    ? ups.editUps(upsActual!)
                    : ups.agregarUps(ups.upsParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Confirmar")),
        ],
      ),
    );
  }
}
