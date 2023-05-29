import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/models/pinpad.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/pinpad_request.dart';
import 'package:soporte_app/providers/request_providers/telefono_request.dart';
import 'package:soporte_app/widgets/form_agregar_impresora.dart';
import 'package:soporte_app/widgets/form_agregar_pinpad.dart';
import 'package:soporte_app/widgets/form_agregar_telefono.dart';

import '../models/impresora.dart';
import '../models/telefono.dart';
import '../providers/request_providers/impresoras_request.dart';
import '../widgets/form_agregar_equipo.dart';
import '../widgets/searchbar.dart';

class PinpadPage extends StatelessWidget {
  const PinpadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinpad = Provider.of<PinpadRequest>(context);
    final _data = pinpad.inSearch == false
        ? pinpad.listaPinpad
        : pinpad.listaBusquedaPinpad;

    _showDeletePopup(Pinpad data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Pinpad ${data.ip} (${data.observaciones} ) de ${data.expand!.sector.nombre}"),
              // Text(
              //     "Al eliminar impresora, tambien eliminará todas las solicitudes asociadas."),
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
                pinpad.deletePinpad(data.id);
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

    _showEditPopup(Pinpad data) {
      Pinpad pinpadActual = data;
      showDialog(
        context: context,
        builder: (context) =>
            FormAgregarPinpad(esEdit: true, pinpadActual: data),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: pinpad.enBusqueda,
            buscar: pinpad.busquedaEnLista,
            getAll: pinpad.getPinpad,
            controller: pinpad.controller,
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
                          Text(data.ip),
                        ),
                        DataCell(
                          Text(data.expand!.sector!.nombre),
                        ),
                        DataCell(
                          Text(data.expand!.sector!.expand!.sucursal.nombre),
                        ),
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
              builder: (context) => FormAgregarPinpad(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
