import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

import 'package:soporte_app/providers/request_providers/toner_request.dart';
import 'package:soporte_app/utils/temporal_vnc.dart';
import 'package:soporte_app/widgets/form_realizar_pedido.dart';

import '../models/toner.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/form_agregar_toner.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/searchbar.dart';

import 'package:path_provider/path_provider.dart';

class TonerPage extends StatelessWidget {
  String nombre;
  TonerPage({Key? key, required this.nombre}) : super(key: key);

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
              Text(
                  "Al eliminar el toner, tambien eliminará todas las solicitudes asociadas."),
              Text("Desea continuar?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Canelar"),
            ),
            TextButton(
              onPressed: () {
                toner.deleteToner(data.id);
                Navigator.pop(context);
              },
              child: Text(
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
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => FormRealizarPedido(),
                    );
                  },
                  child: Text("Realizar Pedido"),
                ),
                height: 50,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
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
                                DataCell(Text('${data.stockFijoPoliclinico}')),
                                DataCell(Text('${data.stockMovilPoliclinico}')),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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
