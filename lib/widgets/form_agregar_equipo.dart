import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarEquipo extends StatelessWidget {
  const FormAgregarEquipo({super.key});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);
    final secYTon = Provider.of<SolicitudTonerRequest>(context);
    final equipo = Provider.of<EquiposRequest>(context);

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
                  equipo.sucursal = value.id;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (equipo.sucursal != "")
                DropdownButtonFormField(
                  decoration: InputDecoration(hintText: 'Sector'),
                  items: secYTon.listaSectoresValue
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    equipo.equipoParaAgregar.sector = value!.id;
                  },
                ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre de equipo'),
                onChanged: (value) => equipo.equipoParaAgregar.nombre = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'IP'),
                onChanged: (value) => equipo.equipoParaAgregar.ip = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Observaciones'),
                onChanged: (value) =>
                    equipo.equipoParaAgregar.observaciones = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Licencia Windows'),
                onChanged: (value) =>
                    equipo.equipoParaAgregar.licenciaWindows = value,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Licencia Office'),
                onChanged: (value) =>
                    equipo.equipoParaAgregar.licenciaOffice = value,
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
                equipo.agregarEquipo(equipo.equipoParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
