import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';

class SolicitudTonerPage extends StatelessWidget {
  const SolicitudTonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudToner = Provider.of<SolicitudTonerRequest>(context);
    final listaSucursales = Provider.of<SucursalesRequest>(context);

    final _data = solicitudToner.listaSolicitudToner;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Sector')),
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Toner')),
                DataColumn(label: Text('Entregado')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                            Text(data.created.toString().split(' ').first)),
                        DataCell(Text(data.expand.sector.nombre)),
                        DataCell(
                            Text(data.expand.sector.expand.sucursal.nombre)),
                        DataCell(Text(data.expand.toner.modelo)),
                        DataCell(Switch(
                          onChanged: (value) => null,
                          value: data.entregado,
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
