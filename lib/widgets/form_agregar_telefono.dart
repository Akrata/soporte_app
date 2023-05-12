import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/telefono_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarTelefono extends StatelessWidget {
  const FormAgregarTelefono({super.key});

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
                  telefono.sucursal = value.id;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (telefono.sucursal != "")
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Sector'),
                  items: secYTon.listaSectoresValue
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    telefono.telefonoParaAgregar.sector = value!.id;
                  },
                ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interno'),
                onChanged: (value) =>
                    telefono.telefonoParaAgregar.interno = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'IP'),
                onChanged: (value) => telefono.telefonoParaAgregar.ip = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Observaciones'),
                onChanged: (value) =>
                    telefono.telefonoParaAgregar.observaciones = value,
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
              child: Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                telefono.agregarTelefono(telefono.telefonoParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}