import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/searchbar.dart';

import '../utils/temporal_vnc.dart';
import '../widgets/form_agregar_equipo.dart';

class EquiposPage extends StatelessWidget {
  final String nombre;
  const EquiposPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equipos = Provider.of<EquiposRequest>(context);
    final data = equipos.inSearch == false
        ? equipos.listaEquipos
        : equipos.listaBusquedaEquipos;

    // ignore: no_leading_underscores_for_local_identifiers
    _showDeletePopup(Equipo data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Equipo ${data.ip}, tanto de Sanatorio como de Policlinico"),
              // Text(
              //     "Al eliminar el Equipo, tambien eliminará todas las solicitudes asociadas."),
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
                equipos.deleteEquipo(data.id);
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
    _showEditPopup(Equipo data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            FormAgregarEquipo(esEdit: true, equipoActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
              enBusqueda: equipos.enBusqueda,
              buscar: equipos.busquedaEnLista,
              getAll: equipos.getEquipos,
              controller: equipos.controller),
          // Container(
          //   width: 800,
          //   decoration: BoxDecoration(),
          //   child: ListTile(
          //     title: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Buscar',
          //       ),
          //       controller: _controller,
          //     ),
          //     trailing: Container(
          //         width: 100,
          //         child: Row(
          //           children: [
          //             IconButton(
          //               onPressed: () {
          //                 equipos.enBusqueda(true);
          //                 // equipos.searchText = _controller.text;
          //                 equipos.busquedaEnLista(_controller.text);
          //               },
          //               icon: Icon(
          //                 Icons.search,
          //                 color: Colors.blue,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 _controller.clear();
          //                 equipos.enBusqueda(false);
          //                 equipos.getEquipos();
          //               },
          //               icon: Icon(
          //                 Icons.close,
          //                 color: Colors.red,
          //               ),
          //             ),
          //           ],
          //         )),
          //   ),
          // ),
          const SizedBox(
            height: 20,
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
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: DataTable(
                columnSpacing: 50,
                columns: const [
                  DataColumn(
                      label: Text(
                    'Nombre',
                    softWrap: true,
                  )),
                  DataColumn(label: Text('IP')),
                  DataColumn(label: Text('Sector')),
                  DataColumn(label: Text('Sucursal')),
                  // DataColumn(label: Text('Ult_Mant')),
                  DataColumn(label: Text('Observaciones')),
                  // DataColumn(label: Text('Lic_Windows')),
                  // DataColumn(label: Text('Lic_Office')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Tooltip(
                              message: data.nombre,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 100, maxHeight: 20),
                                child: Text(
                                  data.nombre,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SelectableText(
                              data.ip,
                              // softWrap: true,
                            ),
                          ),
                          DataCell(
                            Text(
                              data.expand!.sector.nombre,
                              softWrap: true,
                            ),
                          ),
                          DataCell(
                            Text(
                              data.expand!.sector.expand!.sucursal.nombre,
                              softWrap: true,
                            ),
                          ),
                          // DataCell(
                          //   Text(
                          //     data.ultimoMantenimiento.toString(),
                          //     softWrap: true,
                          //   ),
                          // ),
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
                          // DataCell(
                          //   Text(
                          //     data.licenciaWindows ?? '',
                          //     softWrap: true,
                          //   ),
                          // ),
                          // DataCell(
                          //   Text(
                          //     data.licenciaOffice ?? '',
                          //     softWrap: true,
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
                              IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.green.shade300,
                                ),
                                onPressed: () async {
                                  try {
                                    TemporalVnc()
                                        .generarArchivoVNC(data.ip, 5900);
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('Error al abrir UltraVNC: $e');
                                    }
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
              builder: (context) => const FormAgregarEquipo(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
