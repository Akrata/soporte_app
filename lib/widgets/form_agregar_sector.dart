import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

class FormAgregarSector extends StatelessWidget {
  const FormAgregarSector({super.key});

  @override
  Widget build(BuildContext context) {
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;
    final sector = Provider.of<SectorRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Sector'),
                onChanged: (value) => sector.sectorParaAgregar.nombre = value,
              ),
              DropdownButtonFormField(
                items: listaSucursales
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nombre),
                          value: e,
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Sucursal'),
                onChanged: (value) =>
                    sector.sectorParaAgregar.sucursal = value!.id,
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
                sector.agregarSector(sector.sectorParaAgregar);

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
