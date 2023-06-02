import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/conmutador.dart';
import 'package:soporte_app/providers/request_providers/conmutador_request.dart';

import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/form_agregar_conmutador.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/searchbar.dart';

class ConmutadorPage extends StatelessWidget {
  final String nombre;
  const ConmutadorPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conmutador = Provider.of<ConmutadorRequest>(context);
    final data = conmutador.inSearch == false
        ? conmutador.listaConmutadores
        : conmutador.listaBusquedaConmutador;

    // ignore: no_leading_underscores_for_local_identifiers
    _showDeletePopup(Conmutador data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el conmutador ${data.nombre} (${data.ip})"),
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
                conmutador.deleteConmutador(data.id);
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

    _showEditPopup(Conmutador data) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => FormAgregarConmutador(
          esEdit: true,
          conmutadorActual: data,
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
              enBusqueda: conmutador.enBusqueda,
              buscar: conmutador.busquedaEnLista,
              getAll: conmutador.getConmutador,
              controller: conmutador.controller),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Ip')),
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Observaciones')),
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
                          Text(data.ip),
                        ),
                        DataCell(
                          Text(data.expand!.sucursal.nombre),
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
                                  // ignore: deprecated_member_use
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FormAgregarConmutador(esEdit: false),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
