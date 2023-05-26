import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/sector.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

class FormAgregarSucursal extends StatelessWidget {
  const FormAgregarSucursal({super.key});

  @override
  Widget build(BuildContext context) {
    final sucursal = Provider.of<SucursalesRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre de sucursal'),
                  // onChanged: (value) =>
                  //     sucursal.sucursalParaAgregar.nombre = value,
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
                // sucursal.createRequest(
                //     sucursal.sucursalParaAgregar, 'sucursal');

                Navigator.pop(context);
              },
              child: Text("Agregar")),
        ],
      ),
    );
  }
}
