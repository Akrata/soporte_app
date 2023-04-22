import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/pinpad_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarPinpad extends StatelessWidget {
  const FormAgregarPinpad({super.key});

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
                  pinpad.sucursal = value.id;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (pinpad.sucursal != "")
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'IP'),
                onChanged: (value) => pinpad.pinpadParaAgregar.ip = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripcion'),
                onChanged: (value) =>
                    pinpad.pinpadParaAgregar.descripcion = value,
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
                pinpad.agregarPinpad(pinpad.pinpadParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
