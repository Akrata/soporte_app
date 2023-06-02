import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/screens/sector_screen.dart';
import 'package:soporte_app/widgets/custom_appbar.dart';
import 'package:soporte_app/widgets/form_agregar_sector.dart';

import '../models/sector.dart';
import '../providers/auth/auth_with_pass.dart';
import '../widgets/searchbar.dart';

class SectorPage extends StatelessWidget {
  final String nombre;
  const SectorPage({Key? key, required this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sector = Provider.of<SectorRequest>(context);
    final listaSectores = sector.inSearch == false
        ? sector.listaSectores
        : sector.listaBusquedaSector;
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;

    final user = Provider.of<AuthWithPass>(context);

    _showDeletePopup(Sector data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el sector ${data.nombre}"),
              Text(
                  "Al eliminarlo, también eliminará todo lo asociado al sector, impresoras, equipos, etc"),
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
                sector.deleteSector(data.id);
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

    _showEditPopup(Sector data) {
      showDialog(
        context: context,
        builder: (context) =>
            FormAgregarSector(esEdit: true, sectorActual: data),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(nombre: nombre),
      body: Column(
        children: [
          SearchBarCustom(
            enBusqueda: sector.enBusqueda,
            buscar: sector.busquedaEnLista,
            getAll: sector.obtenerSectores,
            controller: sector.controller,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Sector')),
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: listaSectores
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          Text(data.nombre),
                        ),
                        DataCell(Text('${data.expand!.sucursal.nombre}')),
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
                            SizedBox(
                              width: 40,
                            ),
                            // TextButton(
                            //     onPressed: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) => SectorScreen(
                            //               idSector: data.id,
                            //               nombre: data.nombre));
                            //       // Navigator.push(
                            //       //     context,
                            //       //     MaterialPageRoute(
                            //       //       builder: (context) => SectorScreen(
                            //       //           idSector: data.id,
                            //       //           nombre: data.nombre),
                            //       //     ));
                            //     },
                            //     child: Text("Visualizar Sector"))
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
              builder: (context) => FormAgregarSector(
                esEdit: false,
              ),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
