// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/solicitud_toner.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

class FormAgregarSolicitud extends StatelessWidget {
  const FormAgregarSolicitud({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final suc = Provider.of<SucursalesRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);

    return Form(
      child: Builder(builder: (context) {
        try {
          return AlertDialog(
            title: const Text("Agregar Solicitud"),
            content: Container(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField(
                    decoration: const InputDecoration(hintText: 'Sucursal'),
                    items: suc.listaSucursales
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.nombre),
                            ))
                        .toList(),
                    onChanged: (value) async {
                      secYTon.cambiandoSucursal(value!.id);
                      // print(secYTon.sucursal);
                      await secYTon.getSectorSegunSucursal(value.id);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (secYTon.sucursal != "")
                  DropdownButtonFormField(
                    decoration: const InputDecoration(hintText: 'Sector'),
                    items: secYTon.sucursal != ""
                        ? secYTon.listaSectoresValue
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nombre),
                                ))
                            .toList()
                        : null,
                    onChanged: (value) async {
                      secYTon.sector = value!.id;
                      // print(value.id);
                      await secYTon.getImpresoraSegunSector(value.id);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (secYTon.sector != "")
                  DropdownButtonFormField(
                    decoration: const InputDecoration(hintText: 'Impresora'),
                    items: secYTon.sector != ""
                        ? secYTon.listaImpresorasValue
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text("${e.marca} ${e.modelo}"),
                                ))
                            .toList()
                        : null,
                    onChanged: (value) async {
                      secYTon.impresora = "${value!.marca} ${value.modelo}";
                      await secYTon.getTonerSegunImpresora(value.id);
                      // print(secYTon.impresora);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (secYTon.impresora != "")
                  DropdownButtonFormField(
                    decoration: const InputDecoration(hintText: 'Toner'),
                    items: secYTon.impresora != ""
                        ? secYTon.listaTonerValue
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.expand!.toner!.modelo),
                                ))
                            .toList()
                        : null,
                    onChanged: (value) {
                      // print(value!.toner);
                      secYTon.toner = value!.toner;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Text("Entregado"),
                  //     Checkbox(
                  //         value: secYTon.entregado,
                  //         onChanged: (value) {
                  //           secYTon.entrega(value!);
                  //         })
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  secYTon.limpiarForm();
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  await secYTon.realizarSolicitud(SolicitudToner(
                    sector: secYTon.sector,
                    toner: secYTon.toner,
                  ));

                  Navigator.pop(context);
                },
                child: const Text("Guardar"),
              ),
            ],
          );
        } catch (e) {
          return const Text("error");
        }
      }),
    );
  }
}
