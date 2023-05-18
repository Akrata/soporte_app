import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/conmutador.dart';
import 'package:soporte_app/providers/request_providers/conmutador_request.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/screens/sector_screen.dart';
import 'package:soporte_app/widgets/form_agregar_conmutador.dart';
import 'package:soporte_app/widgets/form_agregar_sector.dart';

import '../models/sector.dart';
import '../providers/auth/auth_with_pass.dart';
import '../widgets/searchbar.dart';

class ConmutadorPage extends StatelessWidget {
  const ConmutadorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conmutador = Provider.of<ConmutadorRequest>(context);
    final _data = conmutador.inSearch == false
        ? conmutador.listaConmutadores
        : conmutador.listaBusquedaConmutador;
    final listaSucursales =
        Provider.of<SucursalesRequest>(context).listaSucursales;

    final user = Provider.of<AuthWithPass>(context);

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
                conmutador.deleteConmutador(data.id);
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

    _showEditPopup(Conmutador data) {
      Conmutador conmutadorActual = data;
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
                  onChanged: (value) => conmutadorActual.nombre = value,
                ),
                TextFormField(
                  initialValue: data.ip,
                  decoration: InputDecoration(labelText: 'ip'),
                  onChanged: (value) => conmutadorActual.ip = value,
                ),
                TextFormField(
                  initialValue: data.observaciones,
                  decoration: InputDecoration(labelText: 'Observaciones'),
                  onChanged: (value) => conmutadorActual.observaciones = value,
                ),
                DropdownButtonFormField(
                  items: listaSucursales
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e,
                          ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Sucursal'),
                  onChanged: (value) => conmutadorActual.sucursal = value!.id,
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
                  conmutador.editConmutador(conmutadorActual);

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
              enBusqueda: conmutador.enBusqueda,
              buscar: conmutador.busquedaEnLista,
              getAll: conmutador.getConmutador),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Ip')),
                DataColumn(label: Text('Obs')),
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          Text(data.nombre),
                        ),
                        DataCell(
                          Text(data.ip),
                        ),
                        DataCell(
                          Text(data.observaciones ?? ''),
                        ),
                        DataCell(
                          Text(data.expand!.sucursal.nombre),
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FormAgregarConmutador(),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
