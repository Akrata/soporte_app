import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../models/impresora.dart';
import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarImpresora extends StatelessWidget {
  final bool esEdit;
  final Impresora? impresoraActual;
  const FormAgregarImpresora(
      {super.key, required this.esEdit, this.impresoraActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final impresora = Provider.of<ImpresorasRequest>(context);
    final toner = Provider.of<TonerRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // DropdownButtonFormField(
                //   decoration: InputDecoration(hintText: 'Sucursal'),
                //   items: listaSucursales
                //       .map((e) => DropdownMenuItem(
                //             child: Text(e.nombre),
                //             value: e,
                //           ))
                //       .toList(),
                //   onChanged: (value) async {
                //     await secYTon.getSectorSegunSucursal(value!.id);
                //     impresora.sucursal = value.id;
                //   },
                // ),

                DropdownButtonFormField(
                  value: esEdit
                      ? listaSucursales.firstWhere((element) =>
                          element.id ==
                          impresoraActual!.expand!.sector!.expand!.sucursal.id)
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
                          ? impresoraActual!.expand!.sector!.sucursal = value.id
                          : impresora.sucursal = value.id;
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
                      impresora.impresoraParaAgregar.sector = value!.id;
                    },
                  ),
                if (esEdit)
                  DropdownButtonFormField(
                    value: secYTon.abriendoSucursal
                        ? null
                        : sector.listaSectores.firstWhere((element) =>
                            element.id == impresoraActual!.expand!.sector!.id),
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
                                impresoraActual!
                                    .expand!.sector!.expand!.sucursal.id)
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.nombre),
                                  value: e,
                                ))
                            .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? impresoraActual!.sector = value!.id
                          : impresora.impresoraParaAgregar.sector = value!.id;
                    },
                  ),

                SizedBox(
                  height: 20,
                ),
                if (impresora.sucursal != "")
                  DropdownButtonFormField(
                    decoration: InputDecoration(hintText: 'Sector'),
                    items: secYTon.listaSectoresValue
                        .map((e) => DropdownMenuItem(
                              child: Text(e.nombre),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) async {
                      impresora.impresoraParaAgregar.sector = value!.id;
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Marca'),
                  initialValue: esEdit ? impresoraActual!.marca : null,
                  onChanged: (value) => esEdit
                      ? impresoraActual!.marca = value
                      : impresora.impresoraParaAgregar.marca = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Modelo'),
                  initialValue: esEdit ? impresoraActual!.modelo : null,
                  onChanged: (value) => esEdit
                      ? impresoraActual!.modelo = value
                      : impresora.impresoraParaAgregar.modelo = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? impresoraActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? impresoraActual!.ip = value
                      : impresora.impresoraParaAgregar.ip = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? impresoraActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? impresoraActual!.observaciones = value
                      : impresora.impresoraParaAgregar.observaciones = value,
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Toner'),
                  items: toner.listaToners
                      .map((e) => DropdownMenuItem(
                            child: Text(e.modelo),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    impresora.impresoraParaAgregar.toner = value!.id;
                  },
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
                    ? impresora.editImpresora(impresoraActual!)
                    : impresora
                        .agregarImpresora(impresora.impresoraParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Confirmar")),
        ],
      ),
    );
  }
}
