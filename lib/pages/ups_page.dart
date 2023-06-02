import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/models/ups.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/ups_request.dart';
import 'package:soporte_app/widgets/form_agregar_ups.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/form_agregar_equipo.dart';
import '../widgets/searchbar.dart';

class UpsPage extends StatelessWidget {
  String nombre;
  UpsPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ups = Provider.of<UpsRequest>(context);
    final _data = ups.inSearch == false ? ups.listaUps : ups.listaBusquedaUps;

    _showDeletePopup(Ups data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Ups ${data.marca} ${data.modelo} de ${data.expand!.sector.nombre} "),
              // Text(
              //     "Al eliminar el Equipo, tambien eliminará todas las solicitudes asociadas."),
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
                ups.deleteUps(data.id);
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

    _showEditPopup(Ups data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => FormAgregarUps(esEdit: true, upsActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: ups.enBusqueda,
            buscar: ups.busquedaEnLista,
            getAll: ups.getUps,
            controller: ups.controller,
          ),
          Row(
            children: [
              // TextButton(
              //     onPressed: () async {
              //       try {
              //         await launch(
              //           '"$ultravncUrl 192.1.1.220',
              //         );
              //       } catch (e) {
              //         print('Error al abrir UltraVNC: $e');
              //       }
              //     },
              //     child: Text("vnc")),
              // SizedBox(
              //   child: TextButton(
              //     onPressed: () {
              //       showDialog(
              //         context: context,
              //         builder: (context) => FormRealizarPedido(),
              //       );
              //     },
              //     child: Text("Realizar Pedido"),
              //   ),
              //   height: 50,
              // ),
            ],
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Marca')),
                DataColumn(label: Text('Modelo')),
                DataColumn(label: Text('Sector')),
                DataColumn(label: Text('Sucursal')),
                // DataColumn(label: Text('Ultimo Mant.')),
                DataColumn(label: Text('Observaciones')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          Tooltip(
                            message: data.marca,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 100, maxHeight: 20),
                              child: Text(
                                data.marca,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Tooltip(
                            message: data.modelo,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 100, maxHeight: 20),
                              child: Text(
                                data.modelo,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(data.expand!.sector.nombre),
                        ),
                        DataCell(
                          Text(data.expand!.sector.expand!.sucursal.nombre),
                        ),
                        // DataCell(
                        //   Text(data.ultimoMantenimiento.toString()),
                        // ),
                        DataCell(
                          Tooltip(
                            message: data.observaciones,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 100, maxHeight: 20),
                              child: Text(
                                data.observaciones ?? '',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
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
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              //TODO:
              builder: (context) => FormAgregarUps(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
