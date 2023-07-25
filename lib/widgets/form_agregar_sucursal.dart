// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  decoration:
                      const InputDecoration(labelText: 'Nombre de sucursal'),
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
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                // sucursal.createRequest(
                //     sucursal.sucursalParaAgregar, 'sucursal');

                Navigator.pop(context);
              },
              child: const Text("Agregar")),
        ],
      ),
    );
  }
}
