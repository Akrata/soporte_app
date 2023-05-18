import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/widgets/searchbar.dart';

import '../widgets/form_agregar_equipo.dart';

class EquiposPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  EquiposPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equipos = Provider.of<EquiposRequest>(context);
    final _data = equipos.inSearch == false
        ? equipos.listaEquipos
        : equipos.listaBusquedaEquipos;

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
                equipos.deleteEquipo(data.id);
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

    _showEditPopup(Equipo data) {
      Equipo equipoActual = data;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: data.nombre,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) => equipoActual.nombre = value,
                ),
                TextFormField(
                  initialValue: data.ip,
                  decoration: InputDecoration(labelText: 'IP'),
                  onChanged: (value) => equipoActual.nombre = value,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: data.observaciones,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  onChanged: (value) => equipoActual.observaciones = value,
                ),
                //TODO:AGREGAR LO QUE FALTA
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar")),
            ElevatedButton(
                onPressed: () {
                  equipos.editEquipo(equipoActual);
                  // print(equipoActual.ip);
                  Navigator.pop(context);
                },
                child: Text("Confirmar")),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SearchBarCustom(
              enBusqueda: equipos.enBusqueda,
              buscar: equipos.busquedaEnLista,
              getAll: equipos.getEquipos),
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
          SizedBox(
            height: 20,
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
                DataColumn(label: Text('Observaciones')),
                DataColumn(label: Text('Ult_Mant')),
                // DataColumn(label: Text('Lic_Windows')),
                // DataColumn(label: Text('Lic_Office')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 100, maxHeight: 20),
                            child: Text(
                              data.nombre,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data.ip,
                            softWrap: true,
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
                        DataCell(
                          Tooltip(
                            message: data.observaciones,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 200, maxHeight: 20),
                              child: Text(
                                data.observaciones ?? '',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            data.ultimoMantenimiento.toString(),
                            softWrap: true,
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
                              onPressed: () {
                                // _showDeletePopup(data);
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
              builder: (context) => FormAgregarEquipo(),
            );
          }),
    );
  }
}
