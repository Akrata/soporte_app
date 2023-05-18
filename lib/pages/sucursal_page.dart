import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/sucursal.dart';

import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/widgets/form_agregar_sucursal.dart';

import '../providers/auth/auth_with_pass.dart';
import '../widgets/searchbar.dart';

class SucursalPage extends StatelessWidget {
  const SucursalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sucursal = Provider.of<SucursalesRequest>(context);

    final listaSucursales = sucursal.inSearch == false
        ? sucursal.listaSucursales
        : sucursal.listaBusquedaSucursal;
    final user = Provider.of<AuthWithPass>(context);

    // _showDeletePopup(Sucursal data) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //               "Esta intentando eliminar por completo la sucursal ${data.nombre}"),
    //           Text(
    //               "Al eliminarlo, también eliminará todo lo asociado al sector, impresoras, equipos, etc"),
    //           Text("Desea continuar?"),
    //         ],
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text("Canelar"),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             sucursal.deleteSucursal(data.id);
    //             Navigator.pop(context);
    //           },
    //           child: Text(
    //             "Eliminar",
    //             style: TextStyle(color: Colors.red),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    _showEditPopup(Sucursal data) {
      Sucursal sucursalActual = data;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: data.nombre,
                  decoration: InputDecoration(labelText: 'Nombre de sucursal'),
                  onChanged: (value) => sucursalActual.nombre = value,
                ),
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
                  // sucursal.editRequest(sucursalActual, 'sucursal');

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
            enBusqueda: sucursal.enBusqueda,
            buscar: sucursal.busquedaEnLista,
            getAll: sucursal.getSucursales,
            controller: sucursal.controller,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: listaSucursales
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          Text(data.nombre),
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
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.delete,
                            //     color: Colors.red.shade300,
                            //   ),
                            //   onPressed: () {
                            //     _showDeletePopup(data);
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FormAgregarSucursal(),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
