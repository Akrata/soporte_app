import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../models/toner.dart';

class FormAgregarToner extends StatelessWidget {
  const FormAgregarToner({super.key});

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);

    return AlertDialog(
      content: Form(
        child: Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Modelo"),
                onChanged: (value) => toner.tonerParaAgregar.modelo = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stock Fijo Pol.Cent"),
                onChanged: (value) => toner
                    .tonerParaAgregar.stockFijoPoliclinico = int.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stock Movil Pol.Cent"),
                onChanged: (value) => toner
                    .tonerParaAgregar.stockMovilPoliclinico = int.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stock Fijo SC"),
                onChanged: (value) => toner
                    .tonerParaAgregar.stockFijoSanatorio = int.parse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Stock Movil SC"),
                onChanged: (value) => toner
                    .tonerParaAgregar.stockMovilSanatorio = int.parse(value),
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
              toner.agregarToner(toner.tonerParaAgregar);
              Navigator.pop(context);
            },
            child: Text("Agregar"))
      ],
    );
  }
}
