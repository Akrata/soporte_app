import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/models/pinpad.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/pinpad_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarPinpad extends StatelessWidget {
  final bool esEdit;
  final Pinpad? pinpadActual;
  const FormAgregarPinpad({super.key, required this.esEdit, this.pinpadActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final pinpad = Provider.of<PinpadRequest>(context);

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
                          pinpadActual!.expand!.sector.expand!.sucursal.id)
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
                          ? pinpadActual!.expand!.sector.sucursal = value.id
                          : pinpad.sucursal = value.id;
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
                      pinpad.pinpadParaAgregar.sector = value!.id;
                    },
                  ),
                if (esEdit)
                  DropdownButtonFormField(
                    value: secYTon.abriendoSucursal
                        ? null
                        : sector.listaSectores.firstWhere((element) =>
                            element.id == pinpadActual!.expand!.sector.id),
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
                                pinpadActual!
                                    .expand!.sector.expand!.sucursal.id)
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.nombre),
                                  value: e,
                                ))
                            .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? pinpadActual!.sector = value!.id
                          : pinpad.pinpadParaAgregar.sector = value!.id;
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? pinpadActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? pinpadActual!.ip = value
                      : pinpad.pinpadParaAgregar.ip = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? pinpadActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? pinpadActual!.observaciones = value
                      : pinpad.pinpadParaAgregar.observaciones = value,
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
                    ? pinpad.editPinpad(pinpadActual!)
                    : pinpad.agregarPinpad(pinpad.pinpadParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Confirmar")),
        ],
      ),
    );
  }
}
