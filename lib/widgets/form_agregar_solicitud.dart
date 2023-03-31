import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/models/sucursal.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

import '../models/toner.dart';

class FormAgregarSolicitud extends StatelessWidget {
  FormAgregarSolicitud({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final suc = Provider.of<SucursalesRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);

    String _sucursal = '';
    String _sector = '';
    String _impresora = '';
    String _toner = '';

    return AlertDialog(
      title: Text("Agregar Solicitud"),
      content: Form(
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
              onChanged: (value) {
                print(value!.nombre);
                _sucursal = value!.nombre;
                secYTon.getSectorSegunSucursal(value.id);
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(hintText: 'Sector'),
              items: secYTon.listaSectoresValue
                  .map((e) => DropdownMenuItem(
                        child: Text(e.nombre),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                _sector = value!.nombre;
                secYTon.getImpresoraSegunSector(value.id);
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(hintText: 'Impresora'),
              items: secYTon.listaImpresorasValue
                  .map((e) => DropdownMenuItem(
                        child: Text("${e.marca} ${e.modelo}"),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                _sector = "${value!.marca} ${value.modelo}";
                secYTon.getTonerSegunImpresora(value.id);
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(hintText: 'Toner'),
              items: secYTon.listaTonerValue
                  .map((e) => DropdownMenuItem(
                        child: Text(e.modelo),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                _toner = value!.modelo;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Entregado"),
                Checkbox(value: false, onChanged: (value) {})
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            print("${_sucursal}${_sector}${_toner}");
          },
          child: Text("Guardar"),
        ),
      ],
    );
  }
}
