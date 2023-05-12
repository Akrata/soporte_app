import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarImpresora extends StatelessWidget {
  const FormAgregarImpresora({super.key});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(hintText: 'Sucursal'),
                items: listaSucursales
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nombre),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) async {
                  await secYTon.getSectorSegunSucursal(value!.id);
                  impresora.sucursal = value.id;
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
                onChanged: (value) =>
                    impresora.impresoraParaAgregar.marca = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo'),
                onChanged: (value) =>
                    impresora.impresoraParaAgregar.modelo = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'IP'),
                onChanged: (value) => impresora.impresoraParaAgregar.ip = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Observaciones'),
                onChanged: (value) =>
                    impresora.impresoraParaAgregar.observaciones = value,
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
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                impresora.agregarImpresora(impresora.impresoraParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
