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
      child: AlertDialog(
        title: Text("Agregar Solicitud"),
        content: Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(hintText: 'Sucursal'),
                items: suc.listaSucursales
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nombre),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) async {
                  secYTon.sucursal = value!.id;
                  // print(secYTon.sucursal);
                  await secYTon.getSectorSegunSucursal(value.id);
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (secYTon.sucursal != "")
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Sector'),
                  items: secYTon.listaSectoresValue
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    secYTon.sector = value!.id;
                    // print(value.id);
                    await secYTon.getImpresoraSegunSector(value.id);
                  },
                ),
              SizedBox(
                height: 20,
              ),
              if (secYTon.sector != "")
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Impresora'),
                  items: secYTon.listaImpresorasValue
                      .map((e) => DropdownMenuItem(
                            child: Text("${e.marca} ${e.modelo}"),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    secYTon.impresora = "${value!.marca} ${value.modelo}";
                    await secYTon.getTonerSegunImpresora(value.id);
                    // print(secYTon.impresora);
                  },
                ),
              SizedBox(
                height: 20,
              ),
              if (secYTon.impresora != "")
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Toner'),
                  items: secYTon.listaTonerValue
                      .map((e) => DropdownMenuItem(
                            child: Text(e.modelo),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    // print(value!.toner);
                    secYTon.toner = value!.toner;
                  },
                ),
              SizedBox(
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
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await secYTon.realizarSolicitud(SolicitudToner(
                sector: secYTon.sector,
                toner: secYTon.toner,
              ));

              Navigator.pop(context);
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
