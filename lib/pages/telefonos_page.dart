// ignore_for_file: no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/telefono_request.dart';
import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/form_agregar_telefono.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/telefono.dart';
import '../widgets/searchbar.dart';

class TelefonosPage extends StatelessWidget {
  final String nombre;
  const TelefonosPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final telefonos = Provider.of<TelefonoRequest>(context);
    final _data = telefonos.inSearch == false
        ? telefonos.listaTelefonos
        : telefonos.listaBusquedaTelefono;

    _showDeletePopup(Telefono data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Telefono ${data.interno} de ${data.expand!.sector.nombre}"),
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
                telefonos.deleteTelefono(data.id);
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

    _showEditPopup(Telefono data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            FormAgregarTelefono(esEdit: true, telefonoActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: telefonos.enBusqueda,
            buscar: telefonos.busquedaEnLista,
            getAll: telefonos.getTelefonos,
            controller: telefonos.controller,
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
                  DataColumn(label: Text('Interno')),
                  DataColumn(label: Text('IP')),
                  DataColumn(label: Text('Sector')),
                  DataColumn(label: Text('Sucursal')),
                  DataColumn(label: Text('Observaciones')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: _data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Text(data.interno),
                          ),
                          DataCell(
                            Text(data.ip),
                          ),
                          DataCell(
                            Text(data.expand!.sector.nombre),
                          ),
                          DataCell(
                            Text(data.expand!.sector.expand!.sucursal.nombre),
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
                              IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.green.shade300,
                                ),
                                onPressed: () async {
                                  try {
                                    await launch("http://${data.ip}");
                                  } catch (e) {
                                    print('Error al abrir UltraVNC: $e');
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
              builder: (context) => const FormAgregarTelefono(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
