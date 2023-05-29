import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

class FormAgregarSector extends StatelessWidget {
  bool esEdit = false;
  Sector? sectorActual;
  FormAgregarSector({super.key, required this.esEdit, this.sectorActual});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);

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
                      ? listaSucursales.firstWhere(
                          (element) => element.id == sectorActual!.sucursal)
                      : null,
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Sucursal'),
                  onChanged: (value) => esEdit
                      ? sectorActual!.sucursal = value!.id
                      : sector.sectorParaAgregar.sucursal = value!.id,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Sector'),
                  initialValue: esEdit ? sectorActual!.nombre : null,
                  onChanged: (value) => esEdit
                      ? sectorActual!.nombre = value
                      : sector.sectorParaAgregar.nombre = value,
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
                    ? sector.editSector(sectorActual!)
                    : sector.agregarSector(sector.sectorParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
