import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../providers/request_providers/sector_request.dart';
import '../providers/request_providers/sucursales_request.dart';

class FormAgregarEquipo extends StatelessWidget {
  bool esEdit = false;
  Equipo? equipoActual;

  FormAgregarEquipo({super.key, required this.esEdit, this.equipoActual});

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
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  value: esEdit
                      ? listaSucursales.firstWhere((element) =>
                          element.id == equipoActual!.expand!.sector.sucursal)
                      : null,
                  decoration: InputDecoration(hintText: 'Sucursal'),
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) async {
                    await secYTon.getSectorSegunSucursal(value!.id);
                    esEdit
                        ? equipoActual!.expand!.sector.sucursal = value.id
                        : equipo.sucursal = value.id;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                if (equipo.sucursal != "")
                  DropdownButtonFormField(
                    value: esEdit
                        ? secYTon.listaSectoresValue.firstWhere(
                            (element) => element.id == equipoActual!.sector)
                        : null,
                    decoration: InputDecoration(hintText: 'Sector'),
                    items: secYTon.listaSectoresValue
                        .map((e) => DropdownMenuItem(
                              child: Text(e.nombre),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) async {
                      esEdit
                          ? equipoActual!.sector = value!.id
                          : equipo.equipoParaAgregar.sector = value!.id;
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre de equipo'),
                  initialValue: esEdit ? equipoActual!.nombre : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.nombre = value
                      : equipo.equipoParaAgregar.nombre = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'IP'),
                  initialValue: esEdit ? equipoActual!.ip : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.ip = value
                      : equipo.equipoParaAgregar.ip = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Licencia Windows'),
                  initialValue: esEdit ? equipoActual!.licenciaWindows : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.licenciaWindows = value
                      : equipo.equipoParaAgregar.licenciaWindows = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Licencia Office'),
                  initialValue: esEdit ? equipoActual!.licenciaOffice : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.licenciaOffice = value
                      : equipo.equipoParaAgregar.licenciaOffice = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  initialValue: esEdit ? equipoActual!.observaciones : null,
                  onChanged: (value) => esEdit
                      ? equipoActual!.observaciones = value
                      : equipo.equipoParaAgregar.observaciones = value,
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
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                esEdit
                    ? equipo.editEquipo(equipoActual!)
                    : equipo.agregarEquipo(equipo.equipoParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
