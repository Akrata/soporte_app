import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/licencia.dart';

import 'package:soporte_app/providers/request_providers/licencia_request.dart';

import 'package:soporte_app/widgets/custom_appbar.dart';

import 'package:soporte_app/widgets/form_agregar_licencia.dart';

import '../widgets/searchbar.dart';

class LicenciaPage extends StatelessWidget {
  final String nombre;
  const LicenciaPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final licencia = Provider.of<LicenciaRequest>(context);
    final data = licencia.inSearch == false
        ? licencia.listaLicencia
        : licencia.listaBuscarLicencia;

    // ignore: no_leading_underscores_for_local_identifiers
    _showDeletePopup(Licencia data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo la licencia ${data.key}, (${data.tipo})"),
              // Text(
              //     "Al eliminarlo, también eliminará todo lo asociado al sector, impresoras, equipos, etc"),
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
                licencia.deleteLicencia(data.id);
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
    _showEditPopup(Licencia data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => FormAgregarLicencia(
          esEdit: true,
          licenciaActual: data,
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
              enBusqueda: licencia.enBusqueda,
              buscar: licencia.busquedaEnLista,
              getAll: licencia.getLicencia,
              controller: licencia.controller),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: DataTable(
                columns: const [
                  DataColumn(label: Text('Key')),
                  DataColumn(label: Text('Tipo')),
                  DataColumn(label: Text('Equipo')),
                  DataColumn(label: Text('Sector')),
                  DataColumn(label: Text('Sucursal')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Tooltip(
                              message: data.key,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 100, maxHeight: 20),
                                child: SelectableText(
                                  data.key,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(data.tipo),
                          ),
                          DataCell(
                            Text(data.expand?.equipo.ip ?? ""),
                          ),
                          DataCell(
                            Text(data.expand?.equipo.expand?.sector.nombre ??
                                ""),
                          ),
                          DataCell(
                            Text(data.expand?.equipo.expand?.sector.expand!
                                    .sucursal.nombre ??
                                ""),
                          ),
                          // DataCell(
                          //   Tooltip(
                          //     message: data.observaciones,
                          //     child: ConstrainedBox(
                          //       constraints: const BoxConstraints(
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
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.remove_red_eye_outlined,
                              //     color: Colors.green.shade300,
                              //   ),
                              //   onPressed: () async {
                              //     try {
                              //       // ignore: deprecated_member_use
                              //       await launch("http://${data.ip}");
                              //     } catch (e) {
                              //       print('Error al abrir UltraVNC: $e');
                              //     }
                              //   },
                              // ),
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const FormAgregarLicencia(esEdit: false),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
