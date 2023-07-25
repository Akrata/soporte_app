// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';

import '../models/toner.dart';

class FormAgregarToner extends StatelessWidget {
  final bool esEdit;
  final Toner? tonerActual;
  final userSucursal;
  const FormAgregarToner(
      {super.key,
      required this.esEdit,
      this.tonerActual,
      required this.userSucursal});

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);

    return AlertDialog(
      content: Form(
        child: Container(
          width: 400,
          child: esEdit
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Modelo"),
                      initialValue: esEdit ? tonerActual!.modelo : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.modelo = value
                          : toner.tonerParaAgregar.modelo = value,
                    ),
                    if (userSucursal == 'Policlinico')
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Stock Fijo Pol.Cent"),
                        initialValue: esEdit
                            ? tonerActual!.stockFijoPoliclinico.toString()
                            : null,
                        onChanged: (value) {
                          if (value != '') {
                            esEdit
                                ? tonerActual!.stockFijoPoliclinico =
                                    int.parse(value)
                                : toner.tonerParaAgregar.stockFijoPoliclinico =
                                    int.parse(value);
                          } else {
                            esEdit
                                ? tonerActual!.stockFijoPoliclinico = 0
                                : toner.tonerParaAgregar.stockFijoPoliclinico =
                                    0;
                          }
                        },
                        // onChanged: (value) => esEdit
                        //     ? tonerActual!.stockFijoPoliclinico =
                        //         int.parse(value)
                        //     : toner.tonerParaAgregar.stockFijoPoliclinico =
                        //         int.parse(value),
                      ),
                    if (userSucursal == 'Policlinico')
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Stock Movil Pol.Cent"),
                        initialValue: esEdit
                            ? tonerActual!.stockMovilPoliclinico.toString()
                            : null,
                        onChanged: (value) {
                          if (value != '') {
                            esEdit
                                ? tonerActual!.stockMovilPoliclinico =
                                    int.parse(value)
                                : toner.tonerParaAgregar.stockMovilPoliclinico =
                                    int.parse(value);
                          } else {
                            esEdit
                                ? tonerActual!.stockMovilPoliclinico = 0
                                : toner.tonerParaAgregar.stockMovilPoliclinico =
                                    0;
                          }
                        },
                      ),
                    if (userSucursal == 'Sanatorio')
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Stock Fijo SC"),
                        initialValue: esEdit
                            ? tonerActual!.stockFijoSanatorio.toString()
                            : null,
                        onChanged: (value) {
                          if (value != '') {
                            esEdit
                                ? tonerActual!.stockFijoSanatorio =
                                    int.parse(value)
                                : toner.tonerParaAgregar.stockFijoSanatorio =
                                    int.parse(value);
                          } else {
                            esEdit
                                ? tonerActual!.stockFijoSanatorio = 0
                                : toner.tonerParaAgregar.stockFijoSanatorio = 0;
                          }
                        },
                      ),
                    if (userSucursal == 'Sanatorio')
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Stock Movil SC"),
                        initialValue: esEdit
                            ? tonerActual!.stockMovilSanatorio.toString()
                            : null,
                        onChanged: (value) {
                          if (value != '') {
                            esEdit
                                ? tonerActual!.stockMovilSanatorio =
                                    int.parse(value)
                                : toner.tonerParaAgregar.stockMovilSanatorio =
                                    int.parse(value);
                          } else {
                            esEdit
                                ? tonerActual!.stockMovilSanatorio = 0
                                : toner.tonerParaAgregar.stockMovilSanatorio =
                                    0;
                          }
                        },
                      ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Modelo"),
                      initialValue: esEdit ? tonerActual!.modelo : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.modelo = value
                          : toner.tonerParaAgregar.modelo = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Stock Fijo Pol.Cent"),
                      initialValue: esEdit
                          ? tonerActual!.stockFijoPoliclinico.toString()
                          : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.stockFijoPoliclinico = int.parse(value)
                          : toner.tonerParaAgregar.stockFijoPoliclinico =
                              int.parse(value),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Stock Movil Pol.Cent"),
                      initialValue: esEdit
                          ? tonerActual!.stockMovilPoliclinico.toString()
                          : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.stockMovilPoliclinico =
                              int.parse(value)
                          : toner.tonerParaAgregar.stockMovilPoliclinico =
                              int.parse(value),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Stock Fijo SC"),
                      initialValue: esEdit
                          ? tonerActual!.stockFijoSanatorio.toString()
                          : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.stockFijoSanatorio = int.parse(value)
                          : toner.tonerParaAgregar.stockFijoSanatorio =
                              int.parse(value),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Stock Movil SC"),
                      initialValue: esEdit
                          ? tonerActual!.stockMovilSanatorio.toString()
                          : null,
                      onChanged: (value) => esEdit
                          ? tonerActual!.stockMovilSanatorio = int.parse(value)
                          : toner.tonerParaAgregar.stockMovilSanatorio =
                              int.parse(value),
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
              esEdit
                  ? toner.editToner(tonerActual!)
                  : toner.agregarToner(toner.tonerParaAgregar);
              Navigator.pop(context);
            },
            child: const Text("Confirmar"))
      ],
    );
  }
}
