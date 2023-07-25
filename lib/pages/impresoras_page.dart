// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/form_agregar_impresora.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/impresora.dart';
import '../providers/request_providers/impresoras_request.dart';

import '../widgets/searchbar.dart';

class ImpresorasPage extends StatelessWidget {
  final String nombre;
  const ImpresorasPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final impresoras = Provider.of<ImpresorasRequest>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = impresoras.inSearch == false
        ? impresoras.listaImpresoras
        : impresoras.listaBusquedaImpresoras;

    // ignore: no_leading_underscores_for_local_identifiers
    _showDeletePopup(Impresora data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo la Impresora ${data.marca} ${data.modelo} de ${data.expand!.sector!.nombre}"),
              const Text(
                  "Al eliminar impresora, tambien eliminará todas las solicitudes asociadas."),
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
                impresoras.deleteImpresora(data.id);
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

    // ignore: no_leading_underscores_for_local_identifiers
    _showEditPopup(Impresora data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            FormAgregarImpresora(esEdit: true, impresoraActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: impresoras.enBusqueda,
            buscar: impresoras.busquedaEnLista,
            getAll: impresoras.getImpresoras,
            controller: impresoras.controller,
          ),
          const Row(
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
          Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: DataTable(
                columns: const [
                  DataColumn(label: Text('Marca')),
                  DataColumn(label: Text('Modelo')),
                  DataColumn(label: Text('IP')),
                  DataColumn(label: Text('Sector')),
                  DataColumn(label: Text('Sucursal')),
                  DataColumn(label: Text('Toner')),
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
                                constraints: const BoxConstraints(
                                    maxWidth: 100, maxHeight: 20),
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
                                constraints: const BoxConstraints(
                                    maxWidth: 100, maxHeight: 20),
                                child: Text(
                                  data.modelo,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(data.ip),
                          ),
                          DataCell(
                            Text(data.expand!.sector!.nombre),
                          ),
                          DataCell(
                            Text(data.expand!.sector!.expand!.sucursal.nombre),
                          ),
                          DataCell(
                            Text(data.expand!.toner!.modelo),
                          ),
                          DataCell(
                            Tooltip(
                              message: data.observaciones,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 100, maxHeight: 20),
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
                              if (data.ip != '')
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.green.shade300,
                                  ),
                                  onPressed: () async {
                                    try {
                                      await launch("https://${data.ip}");
                                    } catch (e) {
                                      // print('Error al abrir UltraVNC: $e');
                                    }
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const FormAgregarImpresora(esEdit: false),
            );
          }),
    );
  }
}
