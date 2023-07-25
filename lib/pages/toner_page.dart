// ignore_for_file: no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

import 'package:soporte_app/providers/request_providers/toner_request.dart';
import 'package:soporte_app/widgets/form_realizar_pedido.dart';

import '../models/toner.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/form_agregar_toner.dart';

import '../widgets/searchbar.dart';

class TonerPage extends StatelessWidget {
  final String nombre;
  const TonerPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);
    final _data =
        toner.inSearch == false ? toner.listaToners : toner.listaBusquedaToner;
    final user = Provider.of<AuthWithPass>(context);

    _showDeletePopup(Toner data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Toner ${data.modelo}, tanto de Sanatorio como de Policlinico"),
              const Text(
                  "Al eliminar el toner, tambien eliminará todas las solicitudes asociadas."),
              const Text("Desea continuar?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Canelar"),
            ),
            TextButton(
              onPressed: () {
                toner.deleteToner(data.id);
                Navigator.pop(context);
              },
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    _showEditPopup(Toner data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => FormAgregarToner(
            esEdit: true,
            tonerActual: data,
            userSucursal: user.usuario.lugarTrabajo),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
              enBusqueda: toner.enBusqueda,
              buscar: toner.busquedaEnLista,
              getAll: toner.getToners,
              controller: toner.controller),
          Row(
            children: [
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => FormRealizarPedido(),
                    );
                  },
                  child: const Text("Realizar Pedido"),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: user.usuario.lugarTrabajo == "Sanatorio"
                    ? DataTable(
                        columns: const [
                          DataColumn(label: Text('Modelo')),
                          DataColumn(label: Text('Stock Fijo SC')),
                          DataColumn(label: Text('Stock Movil SC')),
                          DataColumn(label: Text('Acciones')),
                        ],
                        rows: _data
                            .map(
                              (data) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(data.modelo),
                                  ),
                                  DataCell(Text('${data.stockFijoSanatorio}')),
                                  DataCell(Text('${data.stockMovilSanatorio}')),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.amber.shade300),
                                        onPressed: () {
                                          _showEditPopup(data);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade300,
                                        ),
                                        onPressed: () {
                                          _showDeletePopup(data);
                                        },
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : DataTable(
                        columns: const [
                          DataColumn(label: Text('Modelo')),
                          DataColumn(label: Text('Stock Fijo Pol.Cent')),
                          DataColumn(label: Text('Stock Movil Pol.Cent')),
                          DataColumn(label: Text('Acciones')),
                        ],
                        rows: _data
                            .map(
                              (data) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(data.modelo),
                                  ),
                                  DataCell(
                                      Text('${data.stockFijoPoliclinico}')),
                                  DataCell(
                                      Text('${data.stockMovilPoliclinico}')),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.amber.shade300),
                                        onPressed: () {
                                          _showEditPopup(data);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade300,
                                        ),
                                        onPressed: () {
                                          _showDeletePopup(data);
                                        },
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FormAgregarToner(
                userSucursal: user.usuario.lugarTrabajo,
                esEdit: false,
              ),
            );
          }),
    );
  }
}
