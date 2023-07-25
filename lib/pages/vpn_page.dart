// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, sized_box_for_whitespace, empty_catches

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/vpn_request.dart';
import 'package:soporte_app/utils/temporal_anydesk.dart';
import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/form_agregar_vpn.dart';

import '../models/vpn.dart';
import '../widgets/searchbar.dart';

class VpnPage extends StatelessWidget {
  final String nombre;
  const VpnPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vpn = Provider.of<VpnRequest>(context);
    final _data = vpn.inSearch == false ? vpn.listaVpn : vpn.listaBusquedaVpn;

    _showDeletePopup(VPN data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo la VPN de ${data.usuario}"),
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
                vpn.deleteVpn(data.id);
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

    _showEditPopup(VPN data) {
      VPN vpnActual = data;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => FormAgregarVpn(esEdit: true, vpnActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: vpn.enBusqueda,
            buscar: vpn.busquedaEnLista,
            getAll: vpn.getVpn,
            controller: vpn.controller,
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
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Password')),
                  DataColumn(label: Text('Contacto')),
                  DataColumn(label: Text('Telefono')),
                  DataColumn(label: Text('Anydesk')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: _data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            SelectableText(data.usuario),
                          ),
                          DataCell(
                            SelectableText(data.password),
                          ),

                          DataCell(
                            Text(data.nombreDeContacto ?? ""),
                          ),
                          DataCell(
                            Text(data.telefonoDeContacto ?? ""),
                          ),
                          DataCell(
                            SelectableText(data.anydesk ?? ""),
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
                              IconButton(
                                icon: Icon(
                                  Icons.airplay_rounded,
                                  color: Colors.orange.shade300,
                                ),
                                onPressed: () async {
                                  try {
                                    TemporalAnydesk()
                                        .generarArchivoAnydesk(data.anydesk);
                                  } catch (e) {}
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
              builder: (context) => const FormAgregarVpn(
                esEdit: false,
              ),
            );
          }),
    );
  }
}
