// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soporte_app/models/notebook.dart';

import 'package:soporte_app/providers/request_providers/notebook_request.dart';

import 'package:soporte_app/widgets/custom_appbar.dart';

import 'package:soporte_app/widgets/form_agregar_notebook.dart';

import '../widgets/searchbar.dart';

class NotebookPage extends StatelessWidget {
  final String nombre;
  const NotebookPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notebook = Provider.of<NotebookRequest>(context);
    final data = notebook.inSearch == false
        ? notebook.listaNotebook
        : notebook.ListaBusquedaNotebook;

    // ignore: no_leading_underscores_for_local_identifiers
    _showDeletePopup(Notebook data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo la Notebook ${data.marca} ${data.modelo}  de ${data.usuario!}"),
              // Text(
              //     "Al eliminar impresora, tambien eliminará todas las solicitudes asociadas."),
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
                notebook.deleteNotebook(data.id);
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
    _showEditPopup(Notebook data) {
      Notebook notebookActual = data;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            FormAgregarNotebook(esEdit: true, notebookActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: notebook.enBusqueda,
            buscar: notebook.busquedaEnLista,
            getAll: notebook.getNotebooks,
            controller: notebook.controller,
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
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: DataTable(
                columns: const [
                  DataColumn(label: Text('Marca')),
                  DataColumn(label: Text('Modelo')),
                  DataColumn(label: Text('Año')),
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Tel Contacto')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Text(data.marca),
                          ),
                          DataCell(
                            Text(data.modelo),
                          ),
                          DataCell(
                            Text(data.anio),
                          ),
                          DataCell(
                            Text(data.usuario ?? ""),
                          ),
                          DataCell(
                            Text(data.telefonoDeContacto ?? ""),
                          ),
                          // DataCell(
                          //   Tooltip(
                          //     message: data.observaciones,
                          //     child: ConstrainedBox(
                          //       constraints: BoxConstraints(
                          //           maxWidth: 100, maxHeight: 20),
                          //       child: Text(
                          //         data.observaciones ?? '',
                          //         overflow: TextOverflow.ellipsis,
                          //         softWrap: true,
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const FormAgregarNotebook(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
